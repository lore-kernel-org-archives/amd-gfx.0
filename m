Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A900BCC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 22:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD9110E2C0;
	Tue, 13 Oct 2026 22:32:56 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8F310E2C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 22:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijSTKG/MyISI3EzwAgjHxEHnsC3eYtEfaK+oyVXKaY9hR0zvgcZtGcnq3+E1U4nIhn3U8glK5Yybb1YzhuwekB+A3AVXPBlE0ai4SQRKGdMDHgpK6EGKOKm25aFHcxPS0tNVII7Q4ooiESm5uxgbkZvJnyKPc349ChnGukYQUo0S4g1Ld+u1Yhk4Ml9ep5OElqCcjc+XH916+l2uswwoNDnDHnKgkbl05C/8RPTi7glQnLsOR9ps/Gq9Gx2HhQzCZg0ovQEKdjbwTYfiApvZi4mM08T+K9OW66q+v9VqBYFUNp+MO8DxGd2louS4PsTzxCHDpY6opZnhEON48HFCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSj1DpeB6IJyNUmG+FPdgIhCcwql2FEGnwaVKk1HqqI=;
 b=mqBuA4+9QYPwhvXCh2km45utIxG2JqRQFUqo90aXel/w88lilJJ6snfWDOl+pbnfVSsYRvbLbfGAVcb160fPEdFcgG7AGsvD0T+lVoiZ3TWFKxaI3xQv0KPecS4AMHAIN4Bu1sq8adYt9vaRQfeFUNRy3OQhOsOoPp1JqFH1k8d20bpfLZiyqCGp7pskHzDtAuvKr5AszTj4mDgOfsxW6I0uGT1+Ao+U5U72PPZJz5sIQVKd9AwMNwCyMKTfSM+28SUM6QXLj/x0v9VkPVpBrEJwQVe/oJu7oHix2oKpEay/viZCi3lRwnM0mWNAr9Tosxetw1epbZ7SRH94AX8LMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSj1DpeB6IJyNUmG+FPdgIhCcwql2FEGnwaVKk1HqqI=;
 b=txkSmj3rPYTG2w2PJtRMU7nEJX+iUOJ333gJ3C7ZOcUcwd2XwZU9XYL+8Ux1l3TOva+aFIDMhGG4ykdyBoGjOLz7wm2KgkWBLYZT5+vDJYGNzHkBFAmuVTC+EL67cnvLVGALjLHUzlKqJ1AQf/xFMkce2Grh7HA81If9zNc5E5E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV3PR12MB9185.namprd12.prod.outlook.com
 (2603:10b6:408:199::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 22:32:43 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 22:32:43 +0000
Content-Type: multipart/alternative;
 boundary="------------PXfs8ynWOZupP0qayWIQdSHV"
Message-ID: <a9ead820-9869-4280-b086-76933de4dd34@amd.com>
Date: Tue, 13 Oct 2026 18:32:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: UALink add debugfs selftest
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261013181010.1886675-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261013181010.1886675-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YT3PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::30) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cc64d8-b774-47e4-d41d-08df2979e5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|5023799004|56012099006|11063799006|261009223027099003|10067099003|22082099003|6133799003|18002099003|8096899003|3023799007;
X-Microsoft-Antispam-Message-Info: fKS34yAaKoArsWAEKVqnav5H9orh9ry3TCVpOkTGU6Yhx6BfsvjSpzkCpdReO3XAtVZjwATlRtPQVbCSdwakcNN6jbcxnC/YcvlrY6rZJcwoDrN0VH9Z9lkB8oCNG/hrwG0gF4pMQl2iy6zuv1tdjaT3CidToOoKAPcbxSmRSGgOiY8PRRyhUkHxxpfpOVtfzbfXIzRxJvqidbkjiPKB3PACTWGqJbQ+NTuA3TZQabGsi3utQZdOCw148QGym+bpt7SH8smnS+GN2opr8hkXEDSBEyPKYqsjbAJ+n5XvQ/uxD8Ji5PIbhg5zLXRT8xIjn9+WkMyQk3ijMc9pzEQVeetbSq+Pj/2aCEinsB187ZD7u8L0msEhLR6Ar8K66qcdiMnJbknC83PoGHDL1XDlQmgbY/XzkqK5hTtMY/G+9vVIE6Y4+0LJSwvUyoKlIkV5ZbIgtdeyq0cQC8uTMmvFpGTtB7TALiGEK57AHcNpuJ11ERWup/8r26C5wWTRosSGMV1t8bKfTVMNFxlsx/GYoyIEQwP9/dSrKD3HusmLiug3iSkRYwXgCarGCXEG0MK+I+tSjfeD9JCrFJYtHL9p7uDz9dWbIwUW7osY6l0Poqi5mbhLVQOQSov9L3kxLsd8V0KRV4v/7LdGlye+T9fHwYBNgQU9/GBo5Of7leHvBRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(5023799004)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(6133799003)(18002099003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFozMEJmVWdqNm1oSzA0RVRqb0htc1NqMVVwZHVoRVZlenN2OHdaTEVnSzBV?=
 =?utf-8?B?TE9xZHhCK1JxTmNnQ3FsdW5nY21lSXF1VTJmNzMyNkNHeTQrdzlMUk9Tb0Iw?=
 =?utf-8?B?a1lUT1g1bFM0bWcrZjlPdlVjSjg0Y1U1Zk5JMVJnczdXVlY4WXVpQmc2OXRu?=
 =?utf-8?B?dkZPMmhOUTNkV0RyRzArL1pBMkQ5QXVicW9sQ0JDOHhrNjEyRzAxWkhHbDgw?=
 =?utf-8?B?NTJKNGF2aTVvanRXUDVjbDQwRmJveUdvNHRTcFFtcWFjeXVpY3RoZkRtb2ZR?=
 =?utf-8?B?c0tSVUxIcHN2ejh6U0pMMURIWnlvRm5MTHB4d1p2ZHJzcGF3dGlmTjMwQ0hJ?=
 =?utf-8?B?VHJFUHVPUGx6VlhtTlV2dFZIRWxuTjkvQ0FGTVRoRWV1MkpSK3NuczBvTW9G?=
 =?utf-8?B?Y3QrTkRncmx0Q0htNk94d1hXWG9GRmM1dm1sY3cyWnJOcFRHZjZ5cy9hUkM4?=
 =?utf-8?B?U2N1VGJnNlZhTmMzWmFUS3pmdEIxMUtMaGhYcVpQMWUvTW1hWE1JOGxvSlN3?=
 =?utf-8?B?eWt5V2JtOUJSbGNRb3BwWGl5WG5jaXZpYm9yZFVhek5oSVVIL2F4S2ppOWZK?=
 =?utf-8?B?N3B2bXhaaFluVjQzdVZheHdldmlsb0hpZVh5eW1PVzBSemRIS3U5c1cyalVX?=
 =?utf-8?B?alA1L3pna004SUZsR2kzSCtCWGFERWdOYVdaNlNrd0tTTXRzWUxEQ3BZcXJT?=
 =?utf-8?B?WU1obWwyRlYxTHgrQVVKcGY1VjRlQ0hSeFRMcnBEZU1Ec2VFK21iWWtvU3JN?=
 =?utf-8?B?dWxoS3VYUU9WWDFCemljOHZlek5yN3h1SGN0cVlGekRQbjNDM3FJeGJxaVc2?=
 =?utf-8?B?K3pRMUE5ZjNJWkVVSXU2akhIYnJhcHJrOWp1anl0Z2E1ZHhESWd5ZFdGQzAx?=
 =?utf-8?B?RXdna2p3MTZYdEhGbHpqbnRURWhqNldnNE9tSlFvTXlpUWw4OWhCd3BuRmhS?=
 =?utf-8?B?dGdCOG5yWDlUNkNMS3FPa0g2aFBocCsrVTF4UDIwczgzejBLbjQ0VnplTk9M?=
 =?utf-8?B?ZEc0NEg3MUJiQkp0NGtRYTdhNUpyMTVpTWhiMk1wMFlyM3hPOUJSQnFrcEZh?=
 =?utf-8?B?UDJ4emJYNndyOU5vZTQwVU9QbkdUVFYyVjA1cklEWkZKbDAwSnV2b2VhQnJh?=
 =?utf-8?B?aE5TdHFPamsvOHJoMG1qOFNNSVhJRDNreUVxekZpc21HRzRidndWU0Q5RXFr?=
 =?utf-8?B?R1Z3VThPQ2xaWDc2MG5iT1FOWmtkdXUyK1I5T3lMT3BLVmhHc1JKT3RmRDll?=
 =?utf-8?B?UHpiVnZ3RkpLUzZzN1Y2UGV0K2pTM0NGYmtVcXJhMXE1TDBoYzFjck9rbldJ?=
 =?utf-8?B?ZFJHTHVPN01LaDk2NDNYY3hXQUFsSEtJWUhLMjZPNWZsQmpTc3dkV2ZaQmFT?=
 =?utf-8?B?TUs4cEF3WmxWWHZrcHRtNHcxbllXTUFRT1JHVUdoWUN5cWNOQUpGU2F0bnNa?=
 =?utf-8?B?UlJ0c1dTbW5IUTZuOE1RT3BpaytpZ2FhemhoUytlVk16ZklFNllHQzFHNE16?=
 =?utf-8?B?bmlOTmRsRzNQVFZWTWtxM2ZNZlZVR0gzazduMktuWSticFFVS29wTTZHeDl5?=
 =?utf-8?B?d2wvRFBydGM5Z3Fvc0d1dXQ3SUtFcE1KWjAxZmk2UWdReGlRR0NucHljWng5?=
 =?utf-8?B?NmwzYjB0Q2wxd1hvYmxTcm04YlZPTlA1QlpqR2dNMWg3UDNiLzZCQkNHaWVL?=
 =?utf-8?B?QXk3M3J3cllBdVEzRHhkS2pQcGMyWXJSTXlzZzJPN1o1ZWNQRkJLWDA4elBG?=
 =?utf-8?B?Y3RkT0FQbTYvdFJJdFp3QVJ2WTkzbjRrYVJGdDVIbGhISkFjRlFCOGpZQ0hL?=
 =?utf-8?B?MmVUR20wZS8wWkRwVVVxQ3RaQ3Zrd0g0MW9kNC9aK1BWSUhMV3A2eWMxM2ZT?=
 =?utf-8?B?bG1PSzdjNEtuODBxK3ZIcytZaEc2cWR0d2xZc0Y3aDJjSzVoQjFlVlY1SVFQ?=
 =?utf-8?B?ZXpaVnpPQ1ZnSUtNOEVTa3BtQjBFUWw0Q3R0U0FaRWxDWEdJUSsvS1VPOGFn?=
 =?utf-8?B?K09uS05RSFp6T21MSG9RcHZUbVIvM05xdlBRaTV1RHFaNEpDZE5qeVVQL1pZ?=
 =?utf-8?B?RUsvYXd5WWpGYk1Cbk50cEZsM1A1UlBqMGZkRkVmYjFGZDhhaUpzZVZidnJE?=
 =?utf-8?B?Qmc5V0lTdDRMeTc5MDZlOWduZStkdzg1b0FNdEJNSUlXWTBmTDBaWjkzSm1U?=
 =?utf-8?B?YSs1NmpwMkMvNUxvQ0JTSzZLR200MzFKMDFZZXdwdEtjQXg3c3FDd0phZGE4?=
 =?utf-8?B?WEVod0VrVkNKa21aS250Mnhsd3RoR2pkNDBFUmtGeG1mNjJveVJyR2YyODlt?=
 =?utf-8?B?V0ZmbXFGUjNCRWtnZk10RkUvNE5va2NLTHo1VU80SWJWOUl0V0kydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cc64d8-b774-47e4-d41d-08df2979e5be
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:32:43.4112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dMRGg4FMrU3Lwz5iF7c5G2SUk7hY4zCs8R+9Ge/NyNLPSmhxlEUYy7V81IzY8uohVOqBQ5dBqF+4xA/16HUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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

--------------PXfs8ynWOZupP0qayWIQdSHV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-10-13 14:10, Philip Yang wrote:
> Add debugfs directory "amdgpu_ualink_test" to trigger UALink selftests
> without userspace application, with three read/write entries:
>
>    command          write the test name to run it, read to list the
>                     valid test names
>    remote_accel_id  accel_id of the remote GPU used by the tests
>    test_size        test buffer size in bytes, from 4 to 8192
>
> Add helper functions: ualink_simple_rw() for remote VRAM R/W,
> ualink_remote_shootdown() for TLB shootdown, ualink_send_hello()
> for handshake, ualink_update_interrupt_wb()
> and ualink_update_shootdown_wb() to read writeback results.
> Use lsdma by default, can select sdma with command.
>
> v4: Use a single "command" entry taking the test name, instead of one
>      entry per test (Felix).
>      Resync the remote wptr before sending a command, the peer may have
>      rebooted.
> v3: Replace the single entry taking a test number with a debugfs
>      directory and a named entry per command.
>      Take peer->lock to update the writeback address and selftest_mutex
>      to read the test parameters.
> v2: Fix typos and issues from copilot code review.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 241 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 249 +++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  15 ++
>   5 files changed, 554 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 3dc95d9accf2..a898a24fda0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2133,9 +2133,237 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +enum amdgpu_ualink_test_cmd {
> +	UALINK_TEST_SW_INIT,
> +	UALINK_TEST_SEND_HELLO,
> +	UALINK_TEST_REMOTE_SHOOTDOWN,
> +	UALINK_TEST_FLUSH_TLB,
> +	UALINK_TEST_READ_LSDMA,
> +	UALINK_TEST_READ_SDMA,
> +	UALINK_TEST_WRITE_LSDMA,
> +	UALINK_TEST_WRITE_SDMA,
> +	UALINK_TEST_UPDATE_INTERRUPT_WB,
> +	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
> +	UALINK_TEST_LSDMA_SELFTEST,
> +};
> +
> +/* commands talking to a remote accelerator, remote_accel_id must be set */
> +#define UALINK_TEST_NEEDS_ACCEL_ID					\
> +	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
> +	 BIT(UALINK_TEST_READ_LSDMA) | BIT(UALINK_TEST_READ_SDMA) |	\
> +	 BIT(UALINK_TEST_WRITE_LSDMA) | BIT(UALINK_TEST_WRITE_SDMA) |	\
> +	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
> +	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
> +
> +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
> +					  enum amdgpu_ualink_test_cmd cmd)
> +{
> +	u32 remote_accel_id = adev->ualink.test_remote_accel_id;
> +	int r = 0;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
> +	    remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
> +		dev_err(adev->dev, "set remote_accel_id first\n");
> +		return -EINVAL;
> +	}
> +
> +	adev->ualink.selftesting = true;
> +
> +	switch (cmd) {
> +	case UALINK_TEST_SW_INIT:
> +		if (adev->ualink.remote)
> +			amdgpu_ualink_sw_fini(adev);
> +
> +		dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
> +		r = amdgpu_ualink_sw_init(adev);
> +		break;
> +	case UALINK_TEST_SEND_HELLO:
> +		r = ualink_send_hello(adev, remote_accel_id);
> +		break;
> +	case UALINK_TEST_REMOTE_SHOOTDOWN:
> +		r = ualink_remote_shootdown(adev, remote_accel_id, 1UL << 30, 1,
> +					    TLB_FLUSH_HEAVYWEIGHT);
> +		break;
> +	case UALINK_TEST_FLUSH_TLB:
> +		ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
> +		break;
> +	case UALINK_TEST_READ_LSDMA:
> +		r = ualink_simple_rw(adev, remote_accel_id, true, true);
> +		break;
> +	case UALINK_TEST_READ_SDMA:
> +		r = ualink_simple_rw(adev, remote_accel_id, true, false);
> +		break;
> +	case UALINK_TEST_WRITE_LSDMA:
> +		r = ualink_simple_rw(adev, remote_accel_id, false, true);
> +		break;
> +	case UALINK_TEST_WRITE_SDMA:
> +		r = ualink_simple_rw(adev, remote_accel_id, false, false);
> +		break;
> +	case UALINK_TEST_UPDATE_INTERRUPT_WB:
> +		r = ualink_update_interrupt_wb(adev, remote_accel_id);
> +		break;
> +	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
> +		r = ualink_update_shootdown_wb(adev, remote_accel_id);
> +		break;
> +	case UALINK_TEST_LSDMA_SELFTEST:
> +		r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	adev->ualink.selftesting = false;
> +
> +	dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret %d\n",
> +		cmd, remote_accel_id, r);
> +
> +	return r;
> +}
> +
> +#define UALINK_TEST_CMD_NAME_MAX	32
> +
> +static const char * const amdgpu_ualink_test_cmd_name[] = {
> +	[UALINK_TEST_SW_INIT]			= "sw_init",
> +	[UALINK_TEST_SEND_HELLO]		= "send_hello",
> +	[UALINK_TEST_REMOTE_SHOOTDOWN]		= "remote_shootdown",
> +	[UALINK_TEST_FLUSH_TLB]			= "flush_tlb",
> +	[UALINK_TEST_READ_LSDMA]		= "read_lsdma",
> +	[UALINK_TEST_READ_SDMA]			= "read_sdma",
> +	[UALINK_TEST_WRITE_LSDMA]		= "write_lsdma",
> +	[UALINK_TEST_WRITE_SDMA]		= "write_sdma",
> +	[UALINK_TEST_UPDATE_INTERRUPT_WB]	= "update_interrupt_wb",
> +	[UALINK_TEST_UPDATE_SHOOTDOWN_WB]	= "update_shootdown_wb",
> +	[UALINK_TEST_LSDMA_SELFTEST]		= "lsdma_selftest",
> +};
> +
> +static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
> +						  char __user *ubuf,
> +						  size_t len, loff_t *offp)
> +{
> +	char buf[UALINK_TEST_CMD_NAME_MAX * ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
> +	unsigned int i;
> +	int n = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
> +		n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
> +			       amdgpu_ualink_test_cmd_name[i]);
> +
> +	return simple_read_from_buffer(ubuf, len, offp, buf, n);
> +}
> +
> +static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
> +						   const char __user *ubuf,
> +						   size_t len, loff_t *offp)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +	char buf[UALINK_TEST_CMD_NAME_MAX];
> +	int cmd, r;
> +
> +	if (len >= sizeof(buf))
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf, ubuf, len))
> +		return -EFAULT;
> +
> +	buf[len] = '\0';
> +	cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
> +	if (cmd < 0) {
> +		dev_err(adev->dev, "unknown ualink test command\n");
> +		return cmd;
> +	}
> +
> +	r = amdgpu_debugfs_ualink_test_run(adev, cmd);
> +	if (r)
> +		return r;
> +
> +	return len;
> +}
> +
> +static const struct file_operations amdgpu_ualink_command_fops = {
> +	.owner	 = THIS_MODULE,
> +	.open	 = simple_open,
> +	.read	 = amdgpu_debugfs_ualink_command_read,
> +	.write	 = amdgpu_debugfs_ualink_command_write,
> +	.llseek	 = default_llseek,
> +};
> +
> +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	*val = adev->ualink.test_remote_accel_id;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	if (!adev->ualink.info)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	if (val >= AMDGPU_UALINK_ACCEL_MAX ||
> +	    !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
> +		dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
> +		return -EINVAL;
> +	}
> +
> +	if (val == adev->ualink.info->ppod.accel_id) {
> +		dev_err(adev->dev, "remote accel_id equals to local accel_id\n");
> +		return -EINVAL;
> +	}
> +
> +	adev->ualink.test_remote_accel_id = val;
> +	dev_info(adev->dev, "set remote accel_id to %llu, local accel_id %u\n",
> +		 val, adev->ualink.info->ppod.accel_id);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
> +			 amdgpu_debugfs_ualink_accel_id_get,
> +			 amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
> +
> +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	*val = adev->ualink.test_size_dwords * 4;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	if (val < 4 || val > 8192)
> +		return -EINVAL;
> +
> +	guard(mutex)(&adev->ualink.selftest_mutex);
> +
> +	adev->ualink.test_size_dwords = val / 4;
> +	dev_dbg(adev->dev, "test buffer size %u bytes\n",
> +		adev->ualink.test_size_dwords * 4);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
> +			 amdgpu_debugfs_ualink_test_size_get,
> +			 amdgpu_debugfs_ualink_test_size_set, "%llu\n");
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> +	struct dentry *ualink_test;
>   	struct dentry *ent;
>   	int r, i;
>   
> @@ -2246,6 +2474,19 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
>   			     &adev->ualink.drop_msg_bitmap);
>   
> +	mutex_init(&adev->ualink.selftest_mutex);
> +	/* 64 bytes test size by default */
> +	adev->ualink.test_size_dwords = 16;
> +	adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
> +
> +	ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
> +	debugfs_create_file("command", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_command_fops);
> +	debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_accel_id_fops);
> +	debugfs_create_file("test_size", 0600, ualink_test, adev,
> +			    &amdgpu_ualink_test_size_fops);
> +
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;
>   	debugfs_create_blob("amdgpu_vbios", 0444, root,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> index 05bc281216bf..1f83d9b69135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
>   	mutex_unlock(&adev->lsdma.lock);
>   	return ret;
>   }
> +
> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ib ib;
> +	int i, r;
> +	u64 gpu_addr;
> +	char *p;
> +	u32 size = 128;
> +
> +	memset(&ib, 0, sizeof(ib));
> +	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &ib);
> +	if (r)
> +		return r;
> +
> +	gpu_addr = ib.gpu_addr;
> +	p = (char *)ib.ptr;
> +	memset(p, 0, 2 * size);
> +
> +	for (i = 0; i < size; i++)
> +		*(p + i) = i;
> +
> +	dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
> +		gpu_addr, gpu_addr + size, size);
> +
> +	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
> +	if (r)
> +		goto out;
> +
> +	p += size;
> +	for (i = 0; i < size; i++) {
> +		if (*(p + i) != i) {
> +			dev_dbg(adev->dev, "data mismatch expecting 0x%x but read 0x%x\n",
> +				i, *(p + i));
> +			break;
> +		}
> +	}
> +	if (i != size)
> +		r = -EIO;
> +
> +out:
> +	amdgpu_ib_free(&ib, NULL);
> +
> +	if (r)
> +		dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
> +	else
> +		dev_dbg(adev->dev, "lsdma selftest passed\n");
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> index 34e92aaa4617..f0a5eeb3529f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
>   			  uint32_t data, uint64_t mem_size);
>   int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
>   			  uint32_t reg_val, uint32_t mask);
> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 6cd3927a7e82..d6c4d98f5143 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -5284,7 +5284,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	if (status != AMDGPU_NHT_FW_ST_PREINIT &&
>   	    status != AMDGPU_NHT_FW_ST_HALT) {
>   		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
> -		return -ENODEV;
> +		if (!adev->ualink.selftesting)
> +			return -ENODEV;
>   	}
>   
>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
> @@ -5333,6 +5334,14 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   		remote->rb_gpu_addr, remote->rb_cpu_addr, adev->gmc.vram_start,
>   		adev->vm_manager.vram_base_offset);
>   
> +	if (adev->ualink.selftesting) {
> +		u32 *p = remote->rb_cpu_addr;
> +		int i;
> +
> +		for (i = 0; i < rb_size / 4; i++)
> +			*(p + i) = 0xdeadbeef;
> +	}
> +
>   	/*
>   	 * address aliasing mode, shared wptr pagee left is not enough for wb data,
>   	 * wb status and rptr, alloc another BO, and then alloc npa address and map
> @@ -5402,6 +5411,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	r = adev->ualink.msg_ctl->send_metadata(adev,
>   						    remote->metadata_gpu_addr,
>   						    AMDGPU_UALINK_ACCEL_MAX << 8);
> +	if (r && adev->ualink.selftesting)
> +		r = 0;
>   
>   out:
>   	if (r)
> @@ -6387,11 +6398,247 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>   	adev->ualink.remote = NULL;
>   }
>   
> +static void dump_buffer(struct amdgpu_device *adev, u32 *src, u32 size_dwords)
> +{
> +	u32 i = 0;
> +	u64 p;
> +
> +	dev_dbg(adev->dev, "buffer 0x%p 0x%x dwords\n", src, size_dwords);
> +
> +	/* at least 64 bytes dump */
> +	size_dwords = ALIGN_DOWN(size_dwords, 16);
> +
> +	while (i < size_dwords) {
> +		p = (u64)(src + i);
> +		dev_dbg(adev->dev, "0x%016llx: 0x%08x 0x%08x 0x%08x 0x%08x\n",
> +			p,
> +			*(src + i),
> +			*(src + i + 1),
> +			*(src + i + 2),
> +			*(src + i + 3));
> +		i += 4;
> +	}
> +}
> +
> +/*
> + * With or without MPNHT FW running, write to remote ring buffer
> + *
> + * Write 16 dwords (64 bytes) to ring buffer, don't update wptr and ring the doorbell
> + *
> + * Dump VRAM content check if remote writing is done correctly
> + *
> + * assuming ring buffer is located at VRAM offset 0x60000000
> + *
> + * root@atitest-MZ01-CE0-00:/home/atitest# cd /sys/kernel/debug/dri/0/amdgpu_ualink_test
> + *
> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test# echo 4 > remote_accel_id
> + *
> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test# echo write_lsdma > command
> + *
> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
> + * 60000000: 00000001 00000002 00000003 00000004	................
> + * 60000010: 00000005 00000006 00000007 00000008	................
> + * 60000020: 00000009 0000000a 0000000b 0000000c	................
> + * 60000030: 0000000d 0000000e 0000000f 00000010	................
> + *
> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test# echo write_lsdma > command
> + *
> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
> + * 60000000: 00000002 00000003 00000004 00000005	................
> + * 60000010: 00000006 00000007 00000008 00000009	................
> + * 60000020: 0000000a 0000000b 0000000c 0000000d	................
> + * 60000030: 0000000e 0000000f 00000010 00000011	................

This is still very cumbersome to use. You need to figure out physical 
addresses of the ring buffers. It would be a lot more convenient, if you 
could read the data directly from debugfs.

I'd suggest replacing the remote access commands 
(UALINK_TEST_READ_LSDMA, UALINK_TEST_READ_SDMA, UALINK_TEST_WRITE_LSDMA, 
UALINK_TEST_WRITE_SDMA) with three debugfs files that can be read and 
written:

  * local_test_data: reads or writes data to the local test buffer (ring
    buffers) that can be accessed by remote GPU
  * remote_sdma: reads or writes data to remote GPU using SDMA
  * remote_lsdma: reads or writes data to remote GPU using LSDMA

Now you have full control over the test data and you can get to the data 
without having to look at debug logs or using xxd with physical addresses.


> + */
> +int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma)

Should these function names have a ualink_test_... prefix?


> +{
> +	struct amdgpu_ualink_remote *remote = to_remote(adev);
> +	u32 test_size_dwords = adev->ualink.test_size_dwords;
> +	struct amdgpu_ualink_peer *peer;
> +	struct amdgpu_ualink_ring *ring;
> +	struct dma_fence *fence;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
> +	u32 seq, ndw, ndw_copy_cmd;
> +	u32 *src_cpu;
> +	u64 src;
> +	int r, i;
> +
> +	if (!remote)
> +		return -EINVAL;
> +
> +	peer = &remote->peer[remote_accel_id];
> +	ring = &peer->interrupt;
> +
> +	/*
> +	 * 1 sdma copy command to write data to ring buffer
> +	 *
> +	 * sdma linear copy command is 7 dwords, align to 8 dwords boundary
> +	 */
> +	ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +
> +	/*
> +	 * 16 dwords data
> +	 */
> +	ndw = ndw_copy_cmd + test_size_dwords;
> +	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
> +				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
> +	if (r)
> +		return r;
> +
> +	mutex_lock(&peer->lock);
> +
> +	ib = job->ibs;
> +	ib->length_dw = 0;
> +	src = ib->gpu_addr + ndw_copy_cmd * 4;
> +	src_cpu = ib->ptr + ndw_copy_cmd;
> +
> +	seq = ++ring->seq;
> +
> +	dev_dbg(adev->dev, "src 0x%llx to npa on gart rb 0x%llx seq 0x%x %s %s\n",
> +		src, ring->rb_npa_gart, seq, read ? "read" : "write",
> +		use_lsdma ? "use lsdma" : "use sdma");
> +
> +	for (i = 0; i < test_size_dwords; i++)
> +		*src_cpu++ = seq + i;
> +
> +	dev_dbg(adev->dev, "dump test buffer data\n");
> +	dump_buffer(adev, ib->ptr + ndw_copy_cmd, test_size_dwords);
> +
> +	remote->use_lsdma = use_lsdma;
> +
> +	dev_dbg(adev->dev, "use %s\n", remote->use_lsdma ? "lsdma" : "sdma");
> +
> +	if (remote->use_lsdma) {
> +		if (read)
> +			r = amdgpu_lsdma_copy_mem(adev, ring->rb_npa_gart, src,
> +						  test_size_dwords * 4);
> +		else
> +			r = amdgpu_lsdma_copy_mem(adev, src, ring->rb_npa_gart,
> +						  test_size_dwords * 4);
> +
> +		amdgpu_job_free(job);
> +		goto out_unlock;
> +	}
> +
> +	/* SDMA commands copy from ib to NPA */
> +	if (read)
> +		amdgpu_emit_copy_buffer(adev, ib, ring->rb_npa_gart, src,
> +					test_size_dwords * 4, 0);
> +	else
> +		amdgpu_emit_copy_buffer(adev, ib, src, ring->rb_npa_gart,
> +					test_size_dwords * 4, 0);
> +
> +	amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
> +	WARN_ON(ib->length_dw > ndw_copy_cmd);
> +
> +	fence = amdgpu_job_submit(job);
> +
> +	/*
> +	 * wait sdma done
> +	 */
> +	r = dma_fence_wait_timeout(fence, false, HZ * 10);
> +	dma_fence_put(fence);
> +	if (r <= 0) {
> +		dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
> +		dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
> +		remote->use_lsdma = true;
> +		r = -ETIME;
> +	} else {
> +		r = 0;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&peer->lock);
> +	if (read) {
> +		dev_dbg(adev->dev, "dump remote read data\n");
> +		dump_buffer(adev, ib->ptr + ndw_copy_cmd, test_size_dwords);
> +	}
> +
> +	dev_dbg(adev->dev, "ret r=%d\n", r);
> +	return r;
> +}
> +
> +/* The peer may have rebooted or the vpod was reconfigured, adopt the remote
> + * wptr before sending a command, same as the handshake does.
> + */
> +static int ualink_resync_peer(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	int r;
> +
> +	if (!adev->ualink.remote)
> +		return -EINVAL;
> +
> +	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
> +	if (r < 0)
> +		return r;
> +
> +	amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
> +
> +	return 0;
> +}
> +
>   int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
>   {
> +	int r;
> +
> +	r = ualink_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
>   	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
>   }
>   
> +void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type)
> +{
> +	amdgpu_ualink_flush_tlb(amdgpu, flush_type);

This function is just a wrapper with the exact same signature. Maybe 
just make the original function non-static and call it directly.

Regards,
   Felix


> +}
> +
> +int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
> +			    u32 size_in_pages, u32 flush_type)
> +{
> +	int r;
> +
> +	r = ualink_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
> +	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
> +					      size_in_pages, flush_type);
> +}
> +
> +int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	int r;
> +
> +	r = ualink_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
> +	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
> +
> +	/* Update interrupt completion write back address */
> +	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
> +					    RB_TYPE_REMOTE_INTERRUPT);
> +	return r;
> +}
> +
> +int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	int r;
> +
> +	r = ualink_resync_peer(adev, remote_accel_id);
> +	if (r)
> +		return r;
> +
> +	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
> +
> +	/* Update shootdown completion write back address */
> +	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
> +					    RB_TYPE_TLB_INV);
> +	return r;
> +}
> +
>   /*
>    * The low bits of handle_lo carry the message-header field on the wire.
>    * Strip those bits and splice in @acc_id to recover the
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 85c9a9634a4b..b381e378dae2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -333,6 +333,13 @@ struct amdgpu_ualink_mgr {
>   	/* For remote interrupt and shootdown */
>   	struct amdgpu_ualink_remote *remote;
>   
> +	/* true for selftest driver path, ignore FW error */
> +	bool selftesting;
> +	/* serialize the selftest debugfs entries */
> +	struct mutex selftest_mutex;
> +	u32 test_size_dwords;
> +	u32 test_remote_accel_id;
> +
>   	/* handle irq from ualink client of remote GPUs */
>   	struct amdgpu_irq_src irq;
>   
> @@ -393,6 +400,14 @@ struct amdgpu_ualink_mgr {
>   int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
>   				 unsigned int client_id, unsigned int src_id);
>   
> +int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma);
> +int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
> +void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type);
> +int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
> +			    u32 size_in_pages, u32 flush_type);
> +int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
> +int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
> +
>   int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
>   
--------------PXfs8ynWOZupP0qayWIQdSHV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-10-13 14:10, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">Add debugfs directory &quot;amdgpu_ualink_test&quot; to trigger UALink selftests
without userspace application, with three read/write entries:

  command          write the test name to run it, read to list the
                   valid test names
  remote_accel_id  accel_id of the remote GPU used by the tests
  test_size        test buffer size in bytes, from 4 to 8192

Add helper functions: ualink_simple_rw() for remote VRAM R/W,
ualink_remote_shootdown() for TLB shootdown, ualink_send_hello()
for handshake, ualink_update_interrupt_wb()
and ualink_update_shootdown_wb() to read writeback results.
Use lsdma by default, can select sdma with command.

v4: Use a single &quot;command&quot; entry taking the test name, instead of one
    entry per test (Felix).
    Resync the remote wptr before sending a command, the peer may have
    rebooted.
v3: Replace the single entry taking a test number with a debugfs
    directory and a named entry per command.
    Take peer-&gt;lock to update the writeback address and selftest_mutex
    to read the test parameters.
v2: Fix typos and issues from copilot code review.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 241 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 249 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  15 ++
 5 files changed, 554 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3dc95d9accf2..a898a24fda0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2133,9 +2133,237 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;);
 
+enum amdgpu_ualink_test_cmd {
+	UALINK_TEST_SW_INIT,
+	UALINK_TEST_SEND_HELLO,
+	UALINK_TEST_REMOTE_SHOOTDOWN,
+	UALINK_TEST_FLUSH_TLB,
+	UALINK_TEST_READ_LSDMA,
+	UALINK_TEST_READ_SDMA,
+	UALINK_TEST_WRITE_LSDMA,
+	UALINK_TEST_WRITE_SDMA,
+	UALINK_TEST_UPDATE_INTERRUPT_WB,
+	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
+	UALINK_TEST_LSDMA_SELFTEST,
+};
+
+/* commands talking to a remote accelerator, remote_accel_id must be set */
+#define UALINK_TEST_NEEDS_ACCEL_ID					\
+	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
+	 BIT(UALINK_TEST_READ_LSDMA) | BIT(UALINK_TEST_READ_SDMA) |	\
+	 BIT(UALINK_TEST_WRITE_LSDMA) | BIT(UALINK_TEST_WRITE_SDMA) |	\
+	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
+	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
+
+static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
+					  enum amdgpu_ualink_test_cmd cmd)
+{
+	u32 remote_accel_id = adev-&gt;ualink.test_remote_accel_id;
+	int r = 0;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	if ((BIT(cmd) &amp; UALINK_TEST_NEEDS_ACCEL_ID) &amp;&amp;
+	    remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev-&gt;dev, &quot;set remote_accel_id first\n&quot;);
+		return -EINVAL;
+	}
+
+	adev-&gt;ualink.selftesting = true;
+
+	switch (cmd) {
+	case UALINK_TEST_SW_INIT:
+		if (adev-&gt;ualink.remote)
+			amdgpu_ualink_sw_fini(adev);
+
+		dev_dbg(adev-&gt;dev, &quot;load metadata init MPNHT firmware\n&quot;);
+		r = amdgpu_ualink_sw_init(adev);
+		break;
+	case UALINK_TEST_SEND_HELLO:
+		r = ualink_send_hello(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_REMOTE_SHOOTDOWN:
+		r = ualink_remote_shootdown(adev, remote_accel_id, 1UL &lt;&lt; 30, 1,
+					    TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_FLUSH_TLB:
+		ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_READ_LSDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, true, true);
+		break;
+	case UALINK_TEST_READ_SDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, true, false);
+		break;
+	case UALINK_TEST_WRITE_LSDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, false, true);
+		break;
+	case UALINK_TEST_WRITE_SDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, false, false);
+		break;
+	case UALINK_TEST_UPDATE_INTERRUPT_WB:
+		r = ualink_update_interrupt_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
+		r = ualink_update_shootdown_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_LSDMA_SELFTEST:
+		r = adev-&gt;lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
+		break;
+	}
+
+	adev-&gt;ualink.selftesting = false;
+
+	dev_dbg(adev-&gt;dev, &quot;ualink test cmd %d remote_accel_id %u ret %d\n&quot;,
+		cmd, remote_accel_id, r);
+
+	return r;
+}
+
+#define UALINK_TEST_CMD_NAME_MAX	32
+
+static const char * const amdgpu_ualink_test_cmd_name[] = {
+	[UALINK_TEST_SW_INIT]			= &quot;sw_init&quot;,
+	[UALINK_TEST_SEND_HELLO]		= &quot;send_hello&quot;,
+	[UALINK_TEST_REMOTE_SHOOTDOWN]		= &quot;remote_shootdown&quot;,
+	[UALINK_TEST_FLUSH_TLB]			= &quot;flush_tlb&quot;,
+	[UALINK_TEST_READ_LSDMA]		= &quot;read_lsdma&quot;,
+	[UALINK_TEST_READ_SDMA]			= &quot;read_sdma&quot;,
+	[UALINK_TEST_WRITE_LSDMA]		= &quot;write_lsdma&quot;,
+	[UALINK_TEST_WRITE_SDMA]		= &quot;write_sdma&quot;,
+	[UALINK_TEST_UPDATE_INTERRUPT_WB]	= &quot;update_interrupt_wb&quot;,
+	[UALINK_TEST_UPDATE_SHOOTDOWN_WB]	= &quot;update_shootdown_wb&quot;,
+	[UALINK_TEST_LSDMA_SELFTEST]		= &quot;lsdma_selftest&quot;,
+};
+
+static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
+						  char __user *ubuf,
+						  size_t len, loff_t *offp)
+{
+	char buf[UALINK_TEST_CMD_NAME_MAX * ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
+	unsigned int i;
+	int n = 0;
+
+	for (i = 0; i &lt; ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
+		n += scnprintf(buf + n, sizeof(buf) - n, &quot;%s\n&quot;,
+			       amdgpu_ualink_test_cmd_name[i]);
+
+	return simple_read_from_buffer(ubuf, len, offp, buf, n);
+}
+
+static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
+						   const char __user *ubuf,
+						   size_t len, loff_t *offp)
+{
+	struct amdgpu_device *adev = file-&gt;private_data;
+	char buf[UALINK_TEST_CMD_NAME_MAX];
+	int cmd, r;
+
+	if (len &gt;= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
+	if (cmd &lt; 0) {
+		dev_err(adev-&gt;dev, &quot;unknown ualink test command\n&quot;);
+		return cmd;
+	}
+
+	r = amdgpu_debugfs_ualink_test_run(adev, cmd);
+	if (r)
+		return r;
+
+	return len;
+}
+
+static const struct file_operations amdgpu_ualink_command_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = simple_open,
+	.read	 = amdgpu_debugfs_ualink_command_read,
+	.write	 = amdgpu_debugfs_ualink_command_write,
+	.llseek	 = default_llseek,
+};
+
+static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	*val = adev-&gt;ualink.test_remote_accel_id;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (!adev-&gt;ualink.info)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	if (val &gt;= AMDGPU_UALINK_ACCEL_MAX ||
+	    !test_bit(val, adev-&gt;ualink.info-&gt;vpod.active_accel_bits)) {
+		dev_err(adev-&gt;dev, &quot;invalid remote accel_id %llu\n&quot;, val);
+		return -EINVAL;
+	}
+
+	if (val == adev-&gt;ualink.info-&gt;ppod.accel_id) {
+		dev_err(adev-&gt;dev, &quot;remote accel_id equals to local accel_id\n&quot;);
+		return -EINVAL;
+	}
+
+	adev-&gt;ualink.test_remote_accel_id = val;
+	dev_info(adev-&gt;dev, &quot;set remote accel_id to %llu, local accel_id %u\n&quot;,
+		 val, adev-&gt;ualink.info-&gt;ppod.accel_id);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
+			 amdgpu_debugfs_ualink_accel_id_get,
+			 amdgpu_debugfs_ualink_accel_id_set, &quot;%llu\n&quot;);
+
+static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	*val = adev-&gt;ualink.test_size_dwords * 4;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (val &lt; 4 || val &gt; 8192)
+		return -EINVAL;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	adev-&gt;ualink.test_size_dwords = val / 4;
+	dev_dbg(adev-&gt;dev, &quot;test buffer size %u bytes\n&quot;,
+		adev-&gt;ualink.test_size_dwords * 4);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
+			 amdgpu_debugfs_ualink_test_size_get,
+			 amdgpu_debugfs_ualink_test_size_set, &quot;%llu\n&quot;);
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)-&gt;primary-&gt;debugfs_root;
+	struct dentry *ualink_test;
 	struct dentry *ent;
 	int r, i;
 
@@ -2246,6 +2474,19 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_ulong(&quot;amdgpu_ualink_drop_msg_bitmap&quot;, 0600, root,
 			     &amp;adev-&gt;ualink.drop_msg_bitmap);
 
+	mutex_init(&amp;adev-&gt;ualink.selftest_mutex);
+	/* 64 bytes test size by default */
+	adev-&gt;ualink.test_size_dwords = 16;
+	adev-&gt;ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
+
+	ualink_test = debugfs_create_dir(&quot;amdgpu_ualink_test&quot;, root);
+	debugfs_create_file(&quot;command&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_command_fops);
+	debugfs_create_file(&quot;remote_accel_id&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_accel_id_fops);
+	debugfs_create_file(&quot;test_size&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_test_size_fops);
+
 	adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios;
 	adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size;
 	debugfs_create_blob(&quot;amdgpu_vbios&quot;, 0444, root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 05bc281216bf..1f83d9b69135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
 	mutex_unlock(&amp;adev-&gt;lsdma.lock);
 	return ret;
 }
+
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
+{
+	struct amdgpu_ib ib;
+	int i, r;
+	u64 gpu_addr;
+	char *p;
+	u32 size = 128;
+
+	memset(&amp;ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &amp;ib);
+	if (r)
+		return r;
+
+	gpu_addr = ib.gpu_addr;
+	p = (char *)ib.ptr;
+	memset(p, 0, 2 * size);
+
+	for (i = 0; i &lt; size; i++)
+		*(p + i) = i;
+
+	dev_dbg(adev-&gt;dev, &quot;copy src 0x%llx dst 0x%llx size %d bytes\n&quot;,
+		gpu_addr, gpu_addr + size, size);
+
+	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
+	if (r)
+		goto out;
+
+	p += size;
+	for (i = 0; i &lt; size; i++) {
+		if (*(p + i) != i) {
+			dev_dbg(adev-&gt;dev, &quot;data mismatch expecting 0x%x but read 0x%x\n&quot;,
+				i, *(p + i));
+			break;
+		}
+	}
+	if (i != size)
+		r = -EIO;
+
+out:
+	amdgpu_ib_free(&amp;ib, NULL);
+
+	if (r)
+		dev_dbg(adev-&gt;dev, &quot;lsdma selftest failed r=%d\n&quot;, r);
+	else
+		dev_dbg(adev-&gt;dev, &quot;lsdma selftest passed\n&quot;);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index 34e92aaa4617..f0a5eeb3529f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
 			  uint32_t data, uint64_t mem_size);
 int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
 			  uint32_t reg_val, uint32_t mask);
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7e82..d6c4d98f5143 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5284,7 +5284,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	if (status != AMDGPU_NHT_FW_ST_PREINIT &amp;&amp;
 	    status != AMDGPU_NHT_FW_ST_HALT) {
 		dev_dbg(adev-&gt;dev, &quot;fw status 0x%x not preinit or halt\n&quot;, status);
-		return -ENODEV;
+		if (!adev-&gt;ualink.selftesting)
+			return -ENODEV;
 	}
 
 	dev_dbg(adev-&gt;dev, &quot;accel_id %u addr_mode %d fw status 0x%x\n&quot;,
@@ -5333,6 +5334,14 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 		remote-&gt;rb_gpu_addr, remote-&gt;rb_cpu_addr, adev-&gt;gmc.vram_start,
 		adev-&gt;vm_manager.vram_base_offset);
 
+	if (adev-&gt;ualink.selftesting) {
+		u32 *p = remote-&gt;rb_cpu_addr;
+		int i;
+
+		for (i = 0; i &lt; rb_size / 4; i++)
+			*(p + i) = 0xdeadbeef;
+	}
+
 	/*
 	 * address aliasing mode, shared wptr pagee left is not enough for wb data,
 	 * wb status and rptr, alloc another BO, and then alloc npa address and map
@@ -5402,6 +5411,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	r = adev-&gt;ualink.msg_ctl-&gt;send_metadata(adev,
 						    remote-&gt;metadata_gpu_addr,
 						    AMDGPU_UALINK_ACCEL_MAX &lt;&lt; 8);
+	if (r &amp;&amp; adev-&gt;ualink.selftesting)
+		r = 0;
 
 out:
 	if (r)
@@ -6387,11 +6398,247 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev-&gt;ualink.remote = NULL;
 }
 
+static void dump_buffer(struct amdgpu_device *adev, u32 *src, u32 size_dwords)
+{
+	u32 i = 0;
+	u64 p;
+
+	dev_dbg(adev-&gt;dev, &quot;buffer 0x%p 0x%x dwords\n&quot;, src, size_dwords);
+
+	/* at least 64 bytes dump */
+	size_dwords = ALIGN_DOWN(size_dwords, 16);
+
+	while (i &lt; size_dwords) {
+		p = (u64)(src + i);
+		dev_dbg(adev-&gt;dev, &quot;0x%016llx: 0x%08x 0x%08x 0x%08x 0x%08x\n&quot;,
+			p,
+			*(src + i),
+			*(src + i + 1),
+			*(src + i + 2),
+			*(src + i + 3));
+		i += 4;
+	}
+}
+
+/*
+ * With or without MPNHT FW running, write to remote ring buffer
+ *
+ * Write 16 dwords (64 bytes) to ring buffer, don't update wptr and ring the doorbell
+ *
+ * Dump VRAM content check if remote writing is done correctly
+ *
+ * assuming ring buffer is located at VRAM offset 0x60000000
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/home/atitest#">atitest-MZ01-CE0-00:/home/atitest#</a> cd /sys/kernel/debug/dri/0/amdgpu_ualink_test
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#</a> echo 4 &gt; remote_accel_id
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#</a> echo write_lsdma &gt; command
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#</a> xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
+ * 60000000: 00000001 00000002 00000003 00000004	................
+ * 60000010: 00000005 00000006 00000007 00000008	................
+ * 60000020: 00000009 0000000a 0000000b 0000000c	................
+ * 60000030: 0000000d 0000000e 0000000f 00000010	................
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#</a> echo write_lsdma &gt; command
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#</a> xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
+ * 60000000: 00000002 00000003 00000004 00000005	................
+ * 60000010: 00000006 00000007 00000008 00000009	................
+ * 60000020: 0000000a 0000000b 0000000c 0000000d	................
+ * 60000030: 0000000e 0000000f 00000010 00000011	................</pre>
    </blockquote>
    <p>This is still very cumbersome to use. You need to figure out
      physical addresses of the ring buffers. It would be a lot more
      convenient, if you could read the data directly from debugfs.</p>
    <p>I'd suggest replacing the remote access commands
      (UALINK_TEST_READ_LSDMA, UALINK_TEST_READ_SDMA,
      UALINK_TEST_WRITE_LSDMA, UALINK_TEST_WRITE_SDMA) with three
      debugfs files that can be read and written:</p>
    <ul>
      <li>local_test_data: reads or writes data to the local test buffer
        (ring buffers) that can be accessed by remote GPU</li>
      <li>remote_sdma: reads or writes data to remote GPU using SDMA</li>
      <li>remote_lsdma: reads or writes data to remote GPU using LSDMA</li>
    </ul>
    <p>Now you have full control over the test data and you can get to
      the data without having to look at debug logs or using xxd with
      physical addresses.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+ */
+int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma)</pre>
    </blockquote>
    <p>Should these function names have a ualink_test_... prefix?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 test_size_dwords = adev-&gt;ualink.test_size_dwords;
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u32 seq, ndw, ndw_copy_cmd;
+	u32 *src_cpu;
+	u64 src;
+	int r, i;
+
+	if (!remote)
+		return -EINVAL;
+
+	peer = &amp;remote-&gt;peer[remote_accel_id];
+	ring = &amp;peer-&gt;interrupt;
+
+	/*
+	 * 1 sdma copy command to write data to ring buffer
+	 *
+	 * sdma linear copy command is 7 dwords, align to 8 dwords boundary
+	 */
+	ndw_copy_cmd = ALIGN(adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
+
+	/*
+	 * 16 dwords data
+	 */
+	ndw = ndw_copy_cmd + test_size_dwords;
+	r = amdgpu_job_alloc_with_ib(adev, &amp;peer-&gt;entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &amp;job);
+	if (r)
+		return r;
+
+	mutex_lock(&amp;peer-&gt;lock);
+
+	ib = job-&gt;ibs;
+	ib-&gt;length_dw = 0;
+	src = ib-&gt;gpu_addr + ndw_copy_cmd * 4;
+	src_cpu = ib-&gt;ptr + ndw_copy_cmd;
+
+	seq = ++ring-&gt;seq;
+
+	dev_dbg(adev-&gt;dev, &quot;src 0x%llx to npa on gart rb 0x%llx seq 0x%x %s %s\n&quot;,
+		src, ring-&gt;rb_npa_gart, seq, read ? &quot;read&quot; : &quot;write&quot;,
+		use_lsdma ? &quot;use lsdma&quot; : &quot;use sdma&quot;);
+
+	for (i = 0; i &lt; test_size_dwords; i++)
+		*src_cpu++ = seq + i;
+
+	dev_dbg(adev-&gt;dev, &quot;dump test buffer data\n&quot;);
+	dump_buffer(adev, ib-&gt;ptr + ndw_copy_cmd, test_size_dwords);
+
+	remote-&gt;use_lsdma = use_lsdma;
+
+	dev_dbg(adev-&gt;dev, &quot;use %s\n&quot;, remote-&gt;use_lsdma ? &quot;lsdma&quot; : &quot;sdma&quot;);
+
+	if (remote-&gt;use_lsdma) {
+		if (read)
+			r = amdgpu_lsdma_copy_mem(adev, ring-&gt;rb_npa_gart, src,
+						  test_size_dwords * 4);
+		else
+			r = amdgpu_lsdma_copy_mem(adev, src, ring-&gt;rb_npa_gart,
+						  test_size_dwords * 4);
+
+		amdgpu_job_free(job);
+		goto out_unlock;
+	}
+
+	/* SDMA commands copy from ib to NPA */
+	if (read)
+		amdgpu_emit_copy_buffer(adev, ib, ring-&gt;rb_npa_gart, src,
+					test_size_dwords * 4, 0);
+	else
+		amdgpu_emit_copy_buffer(adev, ib, src, ring-&gt;rb_npa_gart,
+					test_size_dwords * 4, 0);
+
+	amdgpu_ring_pad_ib(&amp;adev-&gt;sdma.instance[0].ring, ib);
+	WARN_ON(ib-&gt;length_dw &gt; ndw_copy_cmd);
+
+	fence = amdgpu_job_submit(job);
+
+	/*
+	 * wait sdma done
+	 */
+	r = dma_fence_wait_timeout(fence, false, HZ * 10);
+	dma_fence_put(fence);
+	if (r &lt;= 0) {
+		dev_dbg(adev-&gt;dev, &quot;remote sdma fence wait timeout %d\n&quot;, r);
+		dev_dbg(adev-&gt;dev, &quot;use lsdma for testing afterwards\n&quot;);
+		remote-&gt;use_lsdma = true;
+		r = -ETIME;
+	} else {
+		r = 0;
+	}
+
+out_unlock:
+	mutex_unlock(&amp;peer-&gt;lock);
+	if (read) {
+		dev_dbg(adev-&gt;dev, &quot;dump remote read data\n&quot;);
+		dump_buffer(adev, ib-&gt;ptr + ndw_copy_cmd, test_size_dwords);
+	}
+
+	dev_dbg(adev-&gt;dev, &quot;ret r=%d\n&quot;, r);
+	return r;
+}
+
+/* The peer may have rebooted or the vpod was reconfigured, adopt the remote
+ * wptr before sending a command, same as the handshake does.
+ */
+static int ualink_resync_peer(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	if (!adev-&gt;ualink.remote)
+		return -EINVAL;
+
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
+	if (r &lt; 0)
+		return r;
+
+	amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
+
+	return 0;
+}
+
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
 {
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
 	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
 }
 
+void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type)
+{
+	amdgpu_ualink_flush_tlb(amdgpu, flush_type);</pre>
    </blockquote>
    <p>This function is just a wrapper with the exact same signature.
      Maybe just make the original function non-static and call it
      directly.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+}
+
+int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
+			    u32 size_in_pages, u32 flush_type)
+{
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
+					      size_in_pages, flush_type);
+}
+
+int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);
+
+	/* Update interrupt completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_REMOTE_INTERRUPT);
+	return r;
+}
+
+int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);
+
+	/* Update shootdown completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_TLB_INV);
+	return r;
+}
+
 /*
  * The low bits of handle_lo carry the message-header field on the wire.
  * Strip those bits and splice in @acc_id to recover the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..b381e378dae2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -333,6 +333,13 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* true for selftest driver path, ignore FW error */
+	bool selftesting;
+	/* serialize the selftest debugfs entries */
+	struct mutex selftest_mutex;
+	u32 test_size_dwords;
+	u32 test_remote_accel_id;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
@@ -393,6 +400,14 @@ struct amdgpu_ualink_mgr {
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
 				 unsigned int client_id, unsigned int src_id);
 
+int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma);
+int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
+void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type);
+int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
+			    u32 size_in_pages, u32 flush_type);
+int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
</pre>
    </blockquote>
  </body>
</html>

--------------PXfs8ynWOZupP0qayWIQdSHV--
