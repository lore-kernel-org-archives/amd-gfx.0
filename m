Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8724ECAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 19:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7E510E966;
	Fri,  3 Oct 2025 19:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDoc4vWq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9177710E964
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 19:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THeR0j9LzM/jlNZpk9wf8VWzC58bL3zQcEs4sKwXzHmua4CHQdvP7og+Fnaip6vvuZuPKhVGnYnLXC/utFZJA51kw98liHv0RXkYFbaWh5GCx0UqhDCWYKF+8pFBzfuYolfK8zClFLjEjyBFgcGcGvTBKDuP8PQL2cSiioi0LKnFdS1mCX/nNDmX3MQE6aA90zGQio5FEl67/OrJ3V9vmCcmIynAVx3Nx4kwGlPJfsTPwrB9qysnsR07yu59RtT67oPqLvga78hxMqKUwzA5iVg8yO/kVHnQFK8qKKsu16QRGFJVVxu9+d6BrTHgfZf7br6WWiG0JosQiXg6KTs1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y2uc5lNkKRQM03wUEyPO3sg+yqRiT0lfPgFPEXLwNc=;
 b=CDZOU+Xhkpmielu5/fl5f3norfnQDmrFXV4L6r2hTIX3DDx4+aFeJaO9NNobMF5q2swESX64lZEsy8svTAFMFU3BwSl/ldPAiE46hCzn1K+rBG1XiaoXzXF6WOB9KHq2QlY6dB8txA9YRQb6hIJ3C9ICikVthtTzXoCYnq951D/4ROyVfDLmUMKOJxkvXW7zml6Ebydx7uwe2A3qH1GkdHBZwlqAuDydoX2FOAihyqvrgEmo4yRekvDcimrxBVJpQD21yP8j4slrnHsOvTtjKgAn0W/CaN2hM7u4VNMfW7AT+rJ6txzWDI0LILuWT6GUCnSkzVP0/XLVsJ0v3q3aew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y2uc5lNkKRQM03wUEyPO3sg+yqRiT0lfPgFPEXLwNc=;
 b=NDoc4vWqIrD+6DhYO7IUNkY3vUkyicjg//z/JAa6Vxh9bLEfTgXr4yJviDUyRARoGoN9/2IEdl9XekoEbd/z0NqdJCMyanJnFQmQKhnNJySAVJ4LALce/D07ojqdXXNPeVju3ZC55d3SMu9tBDaYLqIuzHBh0pXcUuIgY5kRpl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.16; Fri, 3 Oct 2025 19:10:45 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 19:10:45 +0000
Message-ID: <d6a70010-cf58-4e9b-9980-ed1e45fee891@amd.com>
Date: Fri, 3 Oct 2025 14:10:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-3-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251003181518.24270-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:806:127::14) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbc2217-7b4d-4a78-f44c-08de02b08dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnVnRDkyaDVFMzRzQ0ViR3Q0SVpaQzl5eVlWbEoxQ2JkTU5BdEZuUGhlb1FS?=
 =?utf-8?B?RGY3UEZZQUJzaVVoL3RCS2ZMTWRkWm5mR3ltYndkbTRuUHdTdWZBdnRySXkx?=
 =?utf-8?B?SG1mdXVia1hpQXRyOVcvOWJJbW5ZNnNoaGdjSVdqejhwQWxaallaNmI0TnNL?=
 =?utf-8?B?UW5iRkhxK1NFZ1BaNUpSZTBBWitZV3JZbEh4R3NCRTloeGdROW55ZzJPL2xG?=
 =?utf-8?B?c1ltdHBTMHQ0ZzhDdEZBRTV3ZlFIeGdoOGU0SVJ4dzhFU3h1WS8xU3RMQ2NO?=
 =?utf-8?B?TjQ1OVhmUFZEcStFWGRBeWpqNnV1RWU5RVF4WGNLMGtVOHVBWnpEcXdDb3BQ?=
 =?utf-8?B?cS9KKzUrYUV4aHkzZUFXN0N2TlRtd3NkMGZFdHVPTVZXSlEzOTZtK3g2M1lh?=
 =?utf-8?B?TEl4UEFWS3BLRXUyVnV1NFZkdFUxR21rdFFWa3F6S3RUUkRjMy9jdzJhcTBN?=
 =?utf-8?B?cE5VbGo1YzNucEt2STNVZTJ0R0daSWZFaTdhZzR4MEFCdURNaEtheTV5L3NT?=
 =?utf-8?B?elZleUFxTnBnemcrTWM0VGZIRGlvUUdyaGVTTmZQZnVuTnN4YUVaMUhmUVZk?=
 =?utf-8?B?NkJEQll6ejEwbkNVZVZKWXBwVGQ5eCtTbEt6QncxcDQ0OTNnSnZNVFcrWW9t?=
 =?utf-8?B?dHk1QjdCM1NZTXd2SG5DZnZRWDRTM3FDLy9rYmhFTFRxdllSSGVkcTYrbFdo?=
 =?utf-8?B?cWFERmp6WmRwWWl0NkpHdTFEbWNnSmNFYlZlYTNQZGtmQy9HVkcyYkhBaE9q?=
 =?utf-8?B?c1hoQmVDR3RPMlRYeXpaSTNGbXQ1eVJYZDVqRUtOVTlHNStKSzFNQ0hCdlVw?=
 =?utf-8?B?bFBKTzdjU0VvNXRmcjkxZlRmY2ZicDFBNWtaMktuR3JpaUtPQ05CMjNvRm8r?=
 =?utf-8?B?RW1jNVl2K09ydktQUlE3TTF4VSsvcGRJS1hveTUzUjBOZkdMd3ZnT01KZGR0?=
 =?utf-8?B?Mk94dDFNeGhwWmFHQUZZQmJONDlVeFpyU3NISm9RS1ZOUFR4Mm9xTjJvbjA1?=
 =?utf-8?B?M1M5Mm1aUlJoaDZXMXJPTnVPa01JL2c2dWJISkxvZzkrL2ZibkR6MHN4bFAw?=
 =?utf-8?B?QXNuT1FIVXhsVEdrYVlmZDg1d09ZUG9OQzNQQ3hHYXJkQkhNeit5czJJRFdy?=
 =?utf-8?B?eVVDVXJSSk84eGNUQkMzdHUzMlY0SmgvR1hvN21OYjJCb0p1MzBIRVpjL0p6?=
 =?utf-8?B?RzJSWkFuUDBSZkZPQktjYzlQUjV0N2pMTEdrQXM0SEdQUFFuOExwK0d6ams3?=
 =?utf-8?B?T0JUSlpaMWRHUWxEc2JRUTRNcnBtUmxSQ2Q4RFFCc0treThkM09KMFQ1Mzgy?=
 =?utf-8?B?VkRtQXBDWitsaTI3M2QvNitMQ2lGOFdYb3pMZzFOOFdra3JJRDU5UU52MENL?=
 =?utf-8?B?QTcxQll5UUYxNFJPSTdrVHYwNEF3Z3pqNEh6RWp0cE05c3V0ZVNMN1RNc3VD?=
 =?utf-8?B?OFRONlVUY2xVN1dVSzZCRFhZUVV2bGpNNHBqam5xdjZnZnQ0eDZ2bm1kL21W?=
 =?utf-8?B?V3FyWkl1RmRud0JraWhTd1h3Y1kxS3ZpVHNkUFlqUFlQQ2ZQUFppL2VEMW45?=
 =?utf-8?B?SHZoR0ROY0crVTFhTFZBd0syY2Uyei9HelpCa2doODdCZlZWVGN1NUtPcGJG?=
 =?utf-8?B?ejZmdlJIcndxaUpIbmJ5a0dwRGFONlQrcTRFbHpJTEwrRG5tak52OTFqMmlh?=
 =?utf-8?B?M09yb1ltVTJmM1c0QmhhNFMzcEJVbXl3SzFkcUdleVFDOHB3Y3pNYmtFQjFx?=
 =?utf-8?B?UlBYRUloaW5NMUoxQWNwTDl3QzZQQnp3NFd6NUkyUWZzQVVteG9KL1NGS3dJ?=
 =?utf-8?B?TFB4dlREYUQ2QnZNRHdSRXV1eG9NOTU1aTRhWXhvT0dHVWdXRGhYcS85UEU1?=
 =?utf-8?B?cHBuRUZKZlcxcVd1SGhmTHVHNjNhVEJBcjNlWFQ2djM0emVVM3NGY25PRlNE?=
 =?utf-8?Q?v1rcrTpo5++Blc3xSbTaLW5LoW8d6Yra?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9IT2ZEM3I5RTZKbS9xdEV6ZTBnMkhWamRxOUllRkxrWWJFb1JQOEF0Yncw?=
 =?utf-8?B?dm9sTmx4VDJKUUNHWVRhbTFEMWs0eFZsWWZhNkM0Y2o0dFFBYU8zYTVUQ0lJ?=
 =?utf-8?B?bnFNVzdoZVRYd1JPZ1JMdDRJVkViWjNSTkx6MCtTS3NIN0JGZ0pxWDVUMDFx?=
 =?utf-8?B?UDFuYXZVejVEZkdCSlp5a01URFhBY0JGa2t3RS9NSGgyTitoRkRJYUFDdHlR?=
 =?utf-8?B?VkczQUpmUG9XSllBcEhOTjR5am5hVUc2TFIzQ2Q2Qm9CUmZndjIwYWRENUFY?=
 =?utf-8?B?b1J2L3ppRUVoOGlpWFZ6MFlLTzhvNE15R2JSdGtUcGxSYUJ2ZmZRM2xsOW9u?=
 =?utf-8?B?ZjM4OEFBTWMxWkU0SkhhcXZGUzlBdy9EeEVZODY1YzVrck01cWdUUHpkYmRY?=
 =?utf-8?B?L2dxODNGRDJSSjU5VUxnZnJzdC93bWJiRUU0Ty9ZRzJwNWlWcVpBeWdnOXg0?=
 =?utf-8?B?RXdReEFmUUtvQWJuQ21JT0NnUGtsOHBKc2JIajlXZ0tsRGNOM01EbnhsRlo2?=
 =?utf-8?B?VWtNYWJrZ3Q4cFRvUzY2eGJJMzY4V25kVHR2dWRvSG5hZXJOSUU0YnBPYjAy?=
 =?utf-8?B?a3lQSGwvRmhwMzdJcTRXelFUT3hmTUZtc0xOUTQ1TEhlWlNoNzEwemVEV3VO?=
 =?utf-8?B?ZWFBOG16N1JMQVMzcjRBN1E0YW1TTHdkSWRGN1F0SVNld2poTVk0OWMwSGJp?=
 =?utf-8?B?cGl5UU82RkZ1a2NlbU5IcDFDa3dkSEs3SWgvKzZSdmdWQ3pvRlpGVnNKSWNL?=
 =?utf-8?B?TUlra0pLODRvdUdHdFNEc05PZ2xvMzFac1FQVkVVdVZQZVl1QjJyN1Z0TE94?=
 =?utf-8?B?d0lleWNLQ0JQZ2FPbldFZTdPSXNSOWwzbTN6V0ZranhpbXEvamNZTEFtTWEw?=
 =?utf-8?B?RXRLQWhmanRxa2NqejZGKzduQkFnNnBUUmNLbFh6TlZMMmtqaFFzRWYvODRN?=
 =?utf-8?B?L0YzZG5xR0o4NmZ2d0twcGZSZTI1WTJsWkg1N3p4SjdSYktOZlE1UU9rRlVx?=
 =?utf-8?B?QVlCcHFHU2pMMWxrUytHQ3dDMngwV3pRRGJZVW0xdmppYWF0VG9oWkJjdlhw?=
 =?utf-8?B?WFhlSmdrSCs3SndwdjYzS3FDZFQ5Y2ZoUjQ4Rm1WNktSMDNtR0NBUG1RbDA5?=
 =?utf-8?B?U3FMNnI5VVZoR2MwU1NVaGpXc3l3bzBPZ0paNXdRbnFHbGNRM2dPNU5Da0Y1?=
 =?utf-8?B?Mi82dzdhRkNpMmQzL0k5Q2ZuVmQra09tV1k5R3ZPbjFYMFdlemVxMVRkTVJ1?=
 =?utf-8?B?SU5ycERPRzRwSVZheUpPSnBnV2lvTDVJM3ZSbnJyUUg0Mm5KK2k1K1F5UVB4?=
 =?utf-8?B?VGhRcFFQZ3NyL3Jubnh2djBOLzBtcWMrRGc1aFd4T0RUUGs3dHU1ZndEZkds?=
 =?utf-8?B?WFViMUtkMExkZVRGdW52K3Z2SzR3cVVWRmdSYndlQkhYUXNXYVMxSkNHZTcv?=
 =?utf-8?B?NE1XMkIxa1N5ZVNyUSttVDAxdGoxdFBtQllLOFlpQUwyM0RkZTRPUjNJL24w?=
 =?utf-8?B?WlZpaTdJMkllYS94M3lUd0syb29xM2hBSFNqOS9VbURqM2dqdkh1d3FJOEow?=
 =?utf-8?B?OUx6NmZ1SjY3R1JrYUFlVWkwZk9ENmdZT1kxaTNSblF0M0U0VFZrWkpwck5R?=
 =?utf-8?B?MU51ZWRZaDVBdStMQ2Z5aTg0amk3N2hzZGFkUkw0YSs3aFFHM1RTbVUxQ21m?=
 =?utf-8?B?eFZBcThzcXhXT1BQUEs1VDlsNkJOK3V5SWd2a0hTeGR6b3l2MDBQQlZXN2dF?=
 =?utf-8?B?c0hmTmtLdHR1NzZyVEZRbnVYQ2V1K3Y4T1NyZTZHdFcvU3VqVGFIdEtVUTJF?=
 =?utf-8?B?N3hRUUlPN3lFY0VDRmc1ekRaVzYwc1R1OWxxOTNmN25pK2JBT29CV3IvbzhE?=
 =?utf-8?B?aWM0Z1g3SyszSWQycjJtdG1qMktBa1pibER0ZUk5YmJEQlh1Y2JtV25MKzJF?=
 =?utf-8?B?c0pEaGlBeXRtRXZON09FenBEblpVVU43dTlwYTVnM2lidC9HeDg3NUNHVnlz?=
 =?utf-8?B?QjY3QkVtMEd1ZVcydWlXUHhOYUJ5aWJZQXBQYjM0U0dxQkhNVFdRcUx0T01l?=
 =?utf-8?B?WUJneEN0NXhOL3JGYVV6VU9TMllMeWlsWEF0QWswMlBhWVJVc3QzYVpPYnFV?=
 =?utf-8?Q?A+II=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbc2217-7b4d-4a78-f44c-08de02b08dc0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 19:10:45.0552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyAC3tksK+mzQgLFiCqX1KANrxpKQ4IIN+b1v+SQXqurN1IFmZ+4eePtGokyLh6y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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


Reviewed-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

On 10/3/2025 1:15 PM, Philip Yang wrote:
> If vma is not found, the application has freed the memory using madvise
> MADV_FREE, but driver don't receive the unmap from CPU MMU notifier
> callback, the memory is still mapped on GPUs. svm restore work will
> schedule the work to retry forever. Then user queues not resumed and
> cause application hangs to wait for queue finish.
>
> svm restore work should unmap the memory range from GPUs then resume
> queues. If GPU page fault happens on the unmapped address, it is
> application use-after-free bug.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 75 ++++++++++++++--------------
>   1 file changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 0aadd20be56a..e87c9b3533b9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1708,50 +1708,51 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		bool readonly;
>   
>   		vma = vma_lookup(mm, addr);
> -		if (vma) {
> -			readonly = !(vma->vm_flags & VM_WRITE);
> +		next = vma ? min(vma->vm_end, end) : end;
> +		npages = (next - addr) >> PAGE_SHIFT;
>   
> -			next = min(vma->vm_end, end);
> -			npages = (next - addr) >> PAGE_SHIFT;
> +		if (!vma || !(vma->vm_flags & VM_READ)) {
>   			/* HMM requires at least READ permissions. If provided with PROT_NONE,
>   			 * unmap the memory. If it's not already mapped, this is a no-op
>   			 * If PROT_WRITE is provided without READ, warn first then unmap
> +			 * If vma is not found, addr is invalid, unmap from GPUs
>   			 */
> -			if (!(vma->vm_flags & VM_READ)) {
> -				unsigned long e, s;
> -
> -				svm_range_lock(prange);
> -				if (vma->vm_flags & VM_WRITE)
> -					pr_debug("VM_WRITE without VM_READ is not supported");
> -				s = max(addr >> PAGE_SHIFT, prange->start);
> -				e = s + npages - 1;
> -				r = svm_range_unmap_from_gpus(prange, s, e,
> -						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> -				svm_range_unlock(prange);
> -				/* If unmap returns non-zero, we'll bail on the next for loop
> -				 * iteration, so just leave r and continue
> -				 */
> -				addr = next;
> -				continue;
> -			}
> +			unsigned long e, s;
> +
> +			svm_range_lock(prange);
> +			if (!vma)
> +				pr_debug("vma not found\n");
> +			else if (vma->vm_flags & VM_WRITE)
> +				pr_debug("VM_WRITE without VM_READ is not supported");
> +
> +			s = max(addr >> PAGE_SHIFT, prange->start);
> +			e = s + npages - 1;
> +			r = svm_range_unmap_from_gpus(prange, s, e,
> +					       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> +			svm_range_unlock(prange);
> +			/* If unmap returns non-zero, we'll bail on the next for loop
> +			 * iteration, so just leave r and continue
> +			 */
> +			addr = next;
> +			continue;
> +		}
>   
> -			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> -			if (unlikely(!hmm_range)) {
> -				r = -ENOMEM;
> -			} else {
> -				WRITE_ONCE(p->svms.faulting_task, current);
> -				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -							       readonly, owner,
> -							       hmm_range);
> -				WRITE_ONCE(p->svms.faulting_task, NULL);
> -				if (r) {
> -					kfree(hmm_range);
> -					hmm_range = NULL;
> -					pr_debug("failed %d to get svm range pages\n", r);
> -				}
> -			}
> +		readonly = !(vma->vm_flags & VM_WRITE);
> +
> +		hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> +		if (unlikely(!hmm_range)) {
> +			r = -ENOMEM;
>   		} else {
> -			r = -EFAULT;
> +			WRITE_ONCE(p->svms.faulting_task, current);
> +			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> +						       readonly, owner,
> +						       hmm_range);
> +			WRITE_ONCE(p->svms.faulting_task, NULL);
> +			if (r) {
> +				kfree(hmm_range);
> +				hmm_range = NULL;
> +				pr_debug("failed %d to get svm range pages\n", r);
> +			}
>   		}
>   
>   		if (!r) {
