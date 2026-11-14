Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B4606A32D
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FRRZ7fRI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B43310E16F;
	Sat, 14 Nov 2026 08:36:44 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A46110E224
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKBU8hcYoV9a3rTvCXjyycYnnDWy6zzIdhN6oZnMGVLKd5krncFA/cYU4oSv4D1bRqiVBRpOJAiuihrriS6oCyUhNAWxI3xwcU2UMWuSwfx+elNQ9x9Ninkc/f0YVWrKsfGUb4qEJLB2Eb91VpC0ePVUzQOjkKJKPXZKskXIoeocrC4miUGFgu5CBVuYRyR2fp4X+haSwY4ZV3RO7rpWwsxwig25C9n5znB99R2pIUIMt1rrThyjagtfse5nqkljzA+fD/g8ZHlBeQJefgQRLmnk1n5gGCBsS9dWbLB7/Z8Yqvk4D7FZzitLzkDBPun5PYrpnbxBu4HsYQ2qlBJCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOvWmDkNq66UBeGzexWNpz58t8NeuSoi7Qxz8ZfDsKo=;
 b=BOaJPzQqO5HfTP0qQ27V8tY4mxtu865G/FDlykM+pAwBWl9vqagkWyz7Bw/XBlDsM38x34829pxJG/IuIhqFQ66j6X9eCk0Ww/RD/8XQ/GQCcRKXSagTeUg5v5yKU50Emo2IhHTL/gN5yThRuW15O3XdoNPgtGj5fQGIvBRxU6icxU5B8ZcajF85gnMmwmsbaZABZs4f9bCZaRd2YaoVa+ojrKIwsaLX/XRGZCxOoR+MCKyzBakbMi4KCV72QyTlHOzgTuW37EqeiT0pyBuGPCPT/7whZcT5FU1k/829854Os+SdinOG7gsT5khOMTXxk0jEx/EqveNbSanIcBRa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOvWmDkNq66UBeGzexWNpz58t8NeuSoi7Qxz8ZfDsKo=;
 b=FRRZ7fRIs8AKMLkfzoi4SMXPw007XbgZSgHV3yGhxsh6TM+aKgGFEhCCSEwgunz7r3y7/MdTq0eqDUe5W43msKzBLQVSrMbyba6RyaZyxWV14JCX1K9iRBZQGKHdnIM+jqFqM7T5UBfXT9I0+3NaVAy8Uxtg/FroKHUwTPlOOhc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Sat, 14 Nov
 2026 08:36:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 08:36:32 +0000
Message-ID: <5e95e3e3-227c-44b9-ba0f-2816be36efff@amd.com>
Date: Sat, 14 Nov 2026 14:06:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amd: Select the firmware signing scheme the PSP
 reports
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20261113161521.2132645-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261113161521.2132645-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0142.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6d025d-fcd0-47a4-ae5e-08df422a62b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|6133799003|261022105027099003|5023799004|11063799006|261022075727099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|56012099006|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: SNf1zjTomgLxcmDY4wsgKWsp4TvkBj68/r6ndO0/wB3yqwUcV6WsOnsT5OH1K2kpiEllKRfkcJtoeX65Pd4MdXZZaAyHdYfYpAgkF6DhsJNYD5qL7EVBTLMj4OE5ZZJxtp5JPKnbnyorzvruVp1y3Vlih/UhqcCpN5CvnbAnV2X7MtXBuMYDHtEvPIj47MmRbc6F5EIeJtk+x4fK4ws8vhe8pHRfylRR18Z+eFoFDBOCJK09fFw5ujSCBJH1WHeamqBgEYlih/UaGwX46nSu3QPZ0bwFKCRax4LA0m9srtJ4dGM0gkwpGxxSgcrGqc2YKoU5UIYPtKWcij3jPvAKzyqawwDRYLsjreXExhhIvDm5MSwOd5lTQLXNjUCKCR4nYPmg1TiUASYB/D6huB284BNdSC8Q/Y0vwNRb5iHe9nAZFozyr/euVvdtl+IhZvMLe7mlBuGJY+c71AKBD0xYfhlu/xwMUVTn+ot7Dqr6+bcGtIR4H2b072k9TYw04UdgsuqHO9zEWgTQbGoC/8gg9HDsUl2j3LcKvzFefVSYM7DaVmJS4U/71Uu8u8+ypRmiH98KrLQUkJwMQSSrSH2/luJCmlXOgRfqCpnR4CRUWyFeTloBRkMiPI4q0L7AKi09JaL3Gdd2bUfo7rANlKPAyK6I6Jplaa/ctgloPkK/MTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(261022105027099003)(5023799004)(11063799006)(261022075727099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(56012099006)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5oNWZUWi9FZzlrWUF5RzhXWmVBQVNab0orcTZ2YUd6dWNuNHNURTdIUWJM?=
 =?utf-8?B?OGhoMXNPV3VpRXJtaVI1dERPZHh3M3g0NGwzUzk5NjNHcXdBRHdJb1N3L0xD?=
 =?utf-8?B?eTAwblArUnh3Nk1CNjlXMUt3WC9nQzdqU1lSdjVvTUVzcmF6YW9yYUNVM3Rz?=
 =?utf-8?B?UU5wTVVWa0pqSkNyZjluQ1I5SitwQ3RaMEMwWWI2YVd4Z3NqUmw5NktTUzlB?=
 =?utf-8?B?bGN6VnJtQXdPdC9PVUVnZjdLWlY3a3Roam81ZjlUelh1eWF4NnpWcW44REJs?=
 =?utf-8?B?NmM0QUw0c1RxWGlPVzhQN1RyV3VYYVoxRGNOaXVVYUI2bDFxM0VjS2dTVWFz?=
 =?utf-8?B?c2pkb2VqU2RoYUlGTVhCcWVCQXNVbkR5TDRMbXpuei9Tc09tR1RCdks3RGtt?=
 =?utf-8?B?QytKbmhqaWV6eXdQSi9UTWdDWVAyWDZVMFkzVW1RejdZMVVKWFZNQUExQU9J?=
 =?utf-8?B?djFNT2E1RGM2RHI1Q2krM2o0SmVDcStoYUNhZzdrcWVnN21iMzJnSmVTSUFV?=
 =?utf-8?B?bzBCdEROL3Y5dlhqU2NTaEdyT3RuOXpZaWp0cmJjR2MzUllsNUFhWHdBVFFH?=
 =?utf-8?B?ZjY1KzF1QkNaUG5iL2lkemhzcHdiWW5Ec0pyVFpSczNLYlBtcGJ2eWdrZExW?=
 =?utf-8?B?cHVyREtsYmhuWXpYS09iM3ZTSWdHRDkvZ2pZQzBwdTRKKzNvcDE0MDBCa1Fu?=
 =?utf-8?B?amNQbVdUTEdnMHYvSWpUaFZ5eDg5aW9WQzVPWVVYYmMyb2hWUHBYb1dXYkdx?=
 =?utf-8?B?ZTJpQnRvVDRram1jK0FUdVlCTTlPaUcwYk5nWnRRTlhoT2VvUkNzVmdCNVlR?=
 =?utf-8?B?QzQzL2tDTURJTUFmak41cXRwQndNdFdBSlRpN3lPbzZnUytxS3RSeGZ1ZVg0?=
 =?utf-8?B?aW9KS0hkTVNFaGhpa1FMS2xma0JXOVRtdHNQZ0R5VU9sSkhUSFM4WlErZC9o?=
 =?utf-8?B?UFM0aWxMRC9TbWZCSit6b04zR0wvRlZpTU5ub21qNkk0V0tiMno5bjJsbEVN?=
 =?utf-8?B?SmluRzJGTHZKVmh1Q3ZSMnBibHZaU0JPM1UzdS9VSTk3UUwrcElsbTBqWmE1?=
 =?utf-8?B?Rit6Tko2VFlLUkxQYzh1WmM0ZVUyZktNRDJVNUliaTR2UmRWQnZpNU5Sa0FC?=
 =?utf-8?B?OHhUZnE0VHpIVmNselRNbVZQSkpzZWQvSEVtZ0FxWUJBVDUrQkM0VThKZkc2?=
 =?utf-8?B?NVROU3U0ZWd1OGpodVZkeXUyWEJ4Mk1JaDdRWUxNalRialZCc0IyZkFsVEhm?=
 =?utf-8?B?WXlGaFo2N2pJMmJ5SlJxcXFvUms5eElwR2FMWDY5VWNmeGgyWkZQMlZ2c1pT?=
 =?utf-8?B?YTVyWmhMQ3ppeXBJL3AxVzNBbHBVeldiaXR1ZDlzVDhVT04xWTQrd0I1Z0hy?=
 =?utf-8?B?ZVptWnM1VGRYTzROTS9lMHFmdDVaQnNPMXIxZVYwcSttdEV6QmFvc25uUzl6?=
 =?utf-8?B?bStXRkRmdE9DV3NSaWlyYU9LUkFwOXlZMzhhbllTdDRQQUFPdi9RU1dzT3NT?=
 =?utf-8?B?bm1QWVF6Wk9xLzhMZmFtMXJVOVdySVgzTTMyQ25sMDRoc1NFY2hNaXU3QjNC?=
 =?utf-8?B?eVZmaThRbWQvUE44dUdGbE9XYTd2anp0Ny84QUgxZmlDbEt0T3FSYkkyalhq?=
 =?utf-8?B?cGFSK2Uwd3U4b0taSldDOHJscDloekZpb0kwTHpha3FmWUNPenhJVVFKWkpW?=
 =?utf-8?B?VEp4dnNYY0ZuRTVyTXZwdU92MXNnNVV3dzIzbzFRY3FzOWtYbFkrQ1BpWE5V?=
 =?utf-8?B?aTFVNkZGSHBOYVFEQnQ5eUZGL2lYb2JWMkp6ZE5Jem1DVzFNeXFuNVBiYjdL?=
 =?utf-8?B?WXdaUDJSRlZZL2s3dVJZQi9aa3RMd2FyZjIydHo5UUtlKzJWd0N1dFRUbE0w?=
 =?utf-8?B?TTFPWkNZQVBtNXc3QWNPc2x4enZ5VnFkWlhmY0xzRDAydzE2YTRFQUFtWTZi?=
 =?utf-8?B?Ung5ZGsyc2NQTjhaY2I2N1BXQnZ4OXVOdnFyTWdGRlFpcFMrVTNrQXZXYUpo?=
 =?utf-8?B?MmU3YlVmN3VBd3ZveCtNRDZhUmdmSFBrUHBIVTk0NGFkcUlEV0hwaHhjQkxj?=
 =?utf-8?B?SmFXVkk1eHVEZUJSakMyUHhTWnFWazljOU5KLzJnT0t5UDJQaXc5TXJNejZ4?=
 =?utf-8?B?TUF3NEl1c3hlZTVnbGltNzJWZUpyNzViNE5tOFdUQm5zN1VYTGFzb1RJZDZ2?=
 =?utf-8?B?TWVsdXh6VXpuRkM4Q1o2K3AyUVZnSlhTZFhWR0Z4bk50OXprWXEyR2Y5NEFP?=
 =?utf-8?B?OG13SWNObjNYdWdaN1NrMVBEYnJkSmVqd3JGdkV0T3JCc3VlWi8wN0tKR3JH?=
 =?utf-8?Q?4xhLao9gC3rwP8obyx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6d025d-fcd0-47a4-ae5e-08df422a62b8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 08:36:32.4340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQ2DfG2u1uNgxQ+R2IBuPCctY6QhP1yau38SSMLn9cxQcUcv4aZ5mw/dYtJzDBi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 13-Nov-26 9:45 PM, Mario Limonciello wrote:
> Some platforms ship BIOS with either a default or an alternative trust
> authority, so firmware for every IP must be signed with the matching
> scheme.
> The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit
> 28 whether this is a preproduction part, which needs firmware of its own.
> 
> Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
> own MMIO, and keep the result in adev->firmware.sign_type next to
> load_type, where preproduction is a type of its own. It is initialized
> once, after IP discovery has populated the register bases and only when
> firmware is loaded through the front door (the PSP). Only MP0 15.0.0
> reports it. For all other ASICs, SR-IOV VFs and an inaccessible register
> (all ones) the defaults are kept: AMDGPU_FW_SIGN_DEFAULT. A preproduction
> part that also reports the alternative scheme is not expected, so warn
> about it and use the default firmware.
> 
> Firmware for preproduction parts is named with a "_p" suffix before the
> extension and firmware for the alternative scheme with an "_l" suffix
> (e.g. "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on
> the default scheme use the plain names. Do the substitution centrally in
> amdgpu_ucode_request() so it covers every IP that loads firmware through
> it (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each
> loader having to care. There is no fallback to the default file: it would
> be rejected anyway. Declare the variants with MODULE_FIRMWARE() so that
> initramfs generators include them.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Add unknown type to enum for unexpected combinations (Lijo)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 34 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  9 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 ++++++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  8 +++
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 49 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
>   drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
>   15 files changed, 158 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c60acca7e5cf8..11b64fff853b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2097,6 +2097,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
>   	}
>   
> +	/* Needs the register bases, and must be known before requesting firmware */
> +	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
> +		amdgpu_psp_init_fw_variant(adev);
> +
>   	total = true;
>   	for (i = 0; i < adev->num_ip_blocks; i++) {
>   		ip_block = &adev->ip_blocks[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 548e017311d48..22eb27b4ab5c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -402,6 +402,26 @@ static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
>   	return pos;
>   }
>   
> +/*
> + * Which firmware the platform needs, as reported by the PSP in C2PMSG_63: the
> + * signing scheme and whether this is a preproduction part. The defaults are kept if
> + * the ASIC doesn't report it or it can't be read.
> + */
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
> +	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
> +		psp_v15_0_0_get_fw_variant(adev);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   /*
>    * Helper funciton to query psp runtime database entry
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 975d123593588..9b04e51f589ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
>   
>   int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
>   bool psp_is_xgmi_ta_supported(struct psp_context *psp);
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
>   int psp_xgmi_terminate(struct psp_context *psp);
>   int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
>   int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index d2ce526dd95cc..4d5e31ef8c939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1527,6 +1527,36 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
>   }
>   
> +/* Add the suffix of the firmware variant before the extension: foo.bin -> foo_l.bin */
> +static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fname)
> +{
> +	const char *suffix;
> +	size_t base;
> +
> +	switch (adev->firmware.sign_type) {
> +	case AMDGPU_FW_SIGN_PREPROD:
> +		suffix = "_p.bin";
> +		break;
> +	case AMDGPU_FW_SIGN_ALT:
> +		suffix = "_l.bin";
> +		break;
> +	case AMDGPU_FW_SIGN_UNKNOWN:
> +		/* Unexpected bit combination: try the default binary, it may not work */

Now I see what you meant by default being equivalent to unknown. 
Actually, my thought of keeping a separate unknown was to return -EINVAL 
here or earlier and abort.

Thanks,
Lijo

> +	default:
> +		/* Default variant: the name is unchanged */
> +		return 0;
> +	}
> +
> +	if (!strends(fname, ".bin"))
> +		return -EINVAL;
> +
> +	base = strlen(fname) - strlen(".bin");
> +	if (strscpy(fname + base, suffix, AMDGPU_UCODE_NAME_MAX - base) < 0)
> +		return -EOVERFLOW;
> +
> +	return 0;
> +}
> +
>   /*
>    * amdgpu_ucode_request - Fetch and validate amdgpu microcode
>    *
> @@ -1555,6 +1585,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>   		return -EOVERFLOW;
>   	}
>   
> +	r = amdgpu_ucode_set_suffix(adev, fname);
> +	if (r)
> +		return r;
> +
>   	if (required == AMDGPU_UCODE_REQUIRED)
>   		r = request_firmware(fw, fname, adev->dev);
>   	else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 7c809692807fc..15e789718dede 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -571,6 +571,14 @@ enum amdgpu_firmware_load_type {
>   	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>   };
>   
> +enum amdgpu_firmware_sign_type {
> +	AMDGPU_FW_SIGN_DEFAULT = 0,
> +	AMDGPU_FW_SIGN_ALT,
> +	AMDGPU_FW_SIGN_PREPROD,
> +	/* Unexpected combination of signing bits, default firmware may not work */
> +	AMDGPU_FW_SIGN_UNKNOWN,
> +};
> +
>   enum amdgpu_ucode_required {
>   	AMDGPU_UCODE_OPTIONAL,
>   	AMDGPU_UCODE_REQUIRED,
> @@ -606,6 +614,7 @@ struct amdgpu_firmware_info {
>   struct amdgpu_firmware {
>   	struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
>   	enum amdgpu_firmware_load_type load_type;
> +	enum amdgpu_firmware_sign_type sign_type;
>   	struct amdgpu_bo *fw_buf;
>   	unsigned int fw_size;
>   	unsigned int max_ucodes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6c12d8aa3c769..1df2725d31e0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -66,6 +66,8 @@
>   #define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
>   #define FIRMWARE_VCN5_0_2		"amdgpu/vcn_5_0_2.bin"
>   #define FIRMWARE_VCN5_3_0		"amdgpu/vcn_5_3_0.bin"
> +#define FIRMWARE_VCN5_3_0_ALT		"amdgpu/vcn_5_3_0_l.bin"
> +#define FIRMWARE_VCN5_3_0_PREPROD	"amdgpu/vcn_5_3_0_p.bin"
>   
>   MODULE_FIRMWARE(FIRMWARE_RAVEN);
>   MODULE_FIRMWARE(FIRMWARE_PICASSO);
> @@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..3d82cfbd14f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -134,13 +134,29 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index 09dc01a425d13..a409911939d38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 60b27278a598b..30d3d25d59842 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -61,9 +61,17 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_p.bin");
>   
>   static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index abaa40b6def90..5dbd74549c833 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -32,11 +32,19 @@
>   #include "mp/mp_15_0_0_sh_mask.h"
>   
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
>   
>   #define regMPASP_PCRU0_MPASP_C2PMSG_64                                         0x4280
>   #define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
> @@ -108,6 +116,47 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
>   	return ret;
>   }
>   
> +/*
> + * C2PMSG_63 bit 6: 0 = default firmware signing, 1 = alternative
> + * C2PMSG_63 bit 28: 0 = production part, 1 = preproduction part
> + */
> +#define PSP_V15_0_0_FW_SIGN_ALT		BIT(6)
> +#define PSP_V15_0_0_FW_PREPROD		BIT(28)
> +
> +void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev)
> +{
> +	bool alt, preprod;
> +	u32 val;
> +
> +	if (!adev->reg_offset[MP0_HWIP][0])
> +		return;
> +
> +	val = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
> +	if (val == 0xffffffff) {
> +		drm_warn(adev_to_drm(adev), "Unable to access regMPASP_SMN_C2PMSG_63\n");
> +		return;
> +	}
> +
> +	alt = val & PSP_V15_0_0_FW_SIGN_ALT;
> +	preprod = val & PSP_V15_0_0_FW_PREPROD;
> +
> +	if (alt && preprod) {
> +		drm_warn(adev_to_drm(adev),
> +			 "Preproduction part with alternative signing is unexpected, signing type unknown\n");
> +		adev->firmware.sign_type = AMDGPU_FW_SIGN_UNKNOWN;
> +		return;
> +	}
> +
> +	if (preprod)
> +		adev->firmware.sign_type = AMDGPU_FW_SIGN_PREPROD;
> +	else if (alt)
> +		adev->firmware.sign_type = AMDGPU_FW_SIGN_ALT;
> +
> +	dev_info(adev->dev, "PSP firmware: %s signing, %s part (C2PMSG_63=0x%08x)\n",
> +		 alt ? "alternative" : "default",
> +		 preprod ? "preproduction" : "production", val);
> +}
> +
>   static int psp_v15_0_0_ring_create(struct psp_context *psp,
>   				 enum psp_ring_type ring_type)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> index ebd612103526f..081be8e8268bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> @@ -26,5 +26,6 @@
>   #include "amdgpu_psp.h"
>   
>   void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
> +void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 4845588c4c247..2586d49f1e940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>   
>   #define SDMA1_REG_OFFSET 0x600
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> index c92c5fc59aeb9..cefb8d739faf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> @@ -31,6 +31,8 @@
>   #include "vpe/vpe_2_0_0_sh_mask.h"
>   
>   MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
>   MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>   
>   #define VPE_THREAD1_UCODE_OFFSET	0x8000
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 0ea8f9a582ccc..b28d67b4e70aa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
>   MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> index df3e776c1ad14..219e9c0427441 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> @@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
>   #define FIRMWARE_DCN_36_DMUB		"amdgpu/dcn_3_6_dmcub.bin"
>   #define FIRMWARE_DCN_401_DMUB		"amdgpu/dcn_4_0_1_dmcub.bin"
>   #define FIRMWARE_DCN_42_DMUB		"amdgpu/dcn_4_2_dmcub.bin"
> +#define FIRMWARE_DCN_42_DMUB_ALT	"amdgpu/dcn_4_2_dmcub_l.bin"
> +#define FIRMWARE_DCN_42_DMUB_PREPROD	"amdgpu/dcn_4_2_dmcub_p.bin"
>   #define FIRMWARE_DCN_42B_DMUB		"amdgpu/dcn_4_2_1_dmcub.bin"
>   #define FIRMWARE_DCN_60_DMUB		"amdgpu/dcn_6_0_0_dmcub.bin"
>   #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"

