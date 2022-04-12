Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A736DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 21:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216CC10E7D6;
	Tue, 12 Apr 2022 21:10:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D7D10E7D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 21:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA9DP7rZheIvIKbSYFZpM2aUD6v+S8vnlL2+bKtyFEgqjssZafLITGmVGkKUGUi5cBWQ6vTuIYKdkeBC2egLpI9RRI2BUG7hmNTVYcgpAMxyNJXvtLYPH7lntcuAu16NONW6jnhBwSE+nyxLQloRDlJJZuDvjD60p+T9KsdbpUaXUwUPgLxKnganZeX/gtzg0E14/rhvfezdlEXuU65zexjbRG4Qp3hGmQzIUG+jdTiwn12bvXiKWVaCapFIY95srZFPUBqcMVlKj5+0swMwBGaQE0Uon82S/D61Up8TJtkEhvv3IO3K79vJ9TIIwcr31PXKt8lwn6RAETOguNmQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOMto4gHkYSgub5KUDs7BMRdsTPC6qoGaPTNnAu3wbY=;
 b=m3EU0UTYCMu0xoB2zsIqHMdI3tAe/Vc9BSyC4QtxcBU2ha2xf92zUh/FUMISjikAVG4glFvgjw+2fTlM20M0B10WsQIacrtYrxgP9P0M5Ku2/OpSxpTlTArsj5lARjvQQCY2kg0gPhz3iOzg3W0ixFBUSLHDAAoqf4jWxsxUuhlsLx76+0tXS3SjLt0U0pt/GqM89vJQwpVC0Pcox7r6LV6NdWNdFqlbQc9DUOVVvnVDeHgmVouWcGdEkvB9WO8dIdcGCuA5pwLIhV0jFrvG3vvQuneAuXc0KbJlZltRlszpvktj4j6197fj0ZlOBUYu6OThuRIEJW4Es7IK7VtYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOMto4gHkYSgub5KUDs7BMRdsTPC6qoGaPTNnAu3wbY=;
 b=iafJAQQaQ/WX1bOA3Np54Bvw28BEsthKRv8G3LPFny1NkYr+CKl4IVg0knTO43Qg1zNBY4HKpBXYhp3gGSHq6CtccvHpDoTyUIgVknAGGk8EzLB/QwS+a2+GWVKEBLBUK95/H1G8KGJw9OUUg8ciDOEkj9Yc+kZI+7R5dL8qml0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH2PR12MB5547.namprd12.prod.outlook.com (2603:10b6:610:64::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Tue, 12 Apr 2022 21:09:59 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::3111:c071:1ca6:1e9b]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::3111:c071:1ca6:1e9b%3]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 21:09:59 +0000
Message-ID: <9e2af2ba-b6a1-3056-9125-c0106240ba42@amd.com>
Date: Tue, 12 Apr 2022 17:09:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling in
 send_smc_mesg
Content-Language: en-CA
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220412040801.19905-1-darren.powell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220412040801.19905-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::28) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3045e5a2-4111-4dc0-4e99-08da1cc8cd6a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5547:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB554781EC8B70D6B5E76AC50B99ED9@CH2PR12MB5547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KW6j38CKF6Sewkubh+BYmnaSwNUS4aIdP2gfv1wYN/MJpG3vqbe1GyqzTFQ1Rj3Y3jjYZoBz5+PNbrJ37sNnXCtwvyWmFAqwaAeO7TRpdVyf1cuc5fNQcj919afdh6MM34o1FIRYg9ieB2iC3O+4OptCMp1uStAaWpQHnm7XL0TFsX5fthJx2eBXQbMTUgSQLHy8tzM8yCJJGXbIQph6hPHZCdzVbLdgnA1RMsde8uZZ5H7os8ziQejsg4FYtd0OSRL78nWUg77/ysYP5pWnRTpI7Ok2LoHJtljZTw/AldCKnwtJbimYVZ1U5/bnysfzVQEDu9vzLFzk7SSv2HNazu9AUYnxhic15i2yrkQQiaKvfmUjIHT9+GsefRiUzLsqJhduDadXMBF3da/djQL8eCtl5RkgJ6htDvbkyYvx7ELuy0rkwu+dPkJkvWGfIa5vG8gobHWU6gloLmZRuMPvInKZZWlW/MZzEj3zIzLlMZbiv+Bja5ShQ1w+BaGFrRdA/gbs9VSz6bxt5cC7iSezg/JnI9nOtTuVCx0vDPWhzeXRDQf9tUCf/OZ7sT8t8UuRaOe2UFMMPgtNrxSSXytO8f8OJdY5x/7XGtJfOFLwuPdig9uWp1UFNcXeikfCvihmJXp5ogCesKh0d0LNo/8L2soMCsS26I+04ZI/ThnU9mI589k/0paip6+C0SErIXhiM9SPY4PYM2LVqXaeXxOKHP5t9JrCJvQnP0RQZblOwlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(316002)(26005)(83380400001)(6486002)(86362001)(8936002)(2906002)(38100700002)(31686004)(36756003)(6512007)(44832011)(31696002)(2616005)(508600001)(53546011)(6506007)(6666004)(66556008)(66476007)(4326008)(5660300002)(8676002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVlMDZwTk9BSkJsVkxhZ2U1RThUcUJFNUFGUWJqdzhBekJTVlNza21EeHZm?=
 =?utf-8?B?NUphNXcwbC9sR25yNE45di9HRU1zVzFDQ2tDK1diNFpVSFFTSloxUGdTY0V3?=
 =?utf-8?B?SmtiS0NSSUNnSjJQS2RyVzN6c1hoMXkvREl5Wm1BSzg1c0tjcGNUS2JLRE9J?=
 =?utf-8?B?WE0yaU1HNk13OHI1VEtvSTVVQzJoSUErekhsKzVRNzJIUmhuTjZXMk1paDd5?=
 =?utf-8?B?Zys1cUxMenc1VStlOTlMdHc1SEZ0bDZzV242cDViU3B5NUVaOXlLQjFoTTBk?=
 =?utf-8?B?WllBRDRQTWpjRnUzN01Gak9FY2NBbGxEYTZ4SHd3NExyMjVibEkwTW1ubkNU?=
 =?utf-8?B?ckUzKzZ3b1ViUFpJdlFDeURoeGdvVjdoRGJoejF6dDhWS0JsaXVWeGs5Yy9P?=
 =?utf-8?B?ZElqaFdveTVVbDlrK0hTNGRaOGdqRUJHQ2tEKzNweHlGQUdNbC9vSU1qN3pB?=
 =?utf-8?B?UGZHOG5Hb3MvcmtCMWFNTldENEl0bUE0WnhjdkdJakh3VVBDR2g5NFNCbWQw?=
 =?utf-8?B?aWg0aldaOW5IR2cwbFgxYmdvVm5mZXBQS0pHbUhUSGJjNjFSa3lRYmdtTlJV?=
 =?utf-8?B?Mis1SFQ0TTMvYlNqVmJFWEpYZlB0TTYzUnA0SHR5ZmV5UXA0eGYrdndicVBn?=
 =?utf-8?B?R1FOMDdKemVIRDlWKzFrMFZLNkcvai90d1RQYkZKWUpEZFJOeXhycVFxL0NB?=
 =?utf-8?B?cUJTdS9zR3FhcUo5RFh2citNdmJDRkJOQ3FVOEg1M1gxeURoM2hRQjhPcCt1?=
 =?utf-8?B?eFBtRlF4T1dMM2lxcmowTDI0cmtqNUFPZEQyckQzdFZES01TbnM2Um9nN2Ni?=
 =?utf-8?B?TDZFREpKWDRhV3FSd0I2bzlmOTZEZTRUYm95T0QyRUIwT2Vybi9ZdnhvWjNO?=
 =?utf-8?B?cmltb3NJTjlQektPaGdSQm5nMGpjWGdwV2RqN09mcDBHb3ZVaFRZWmFvWXRu?=
 =?utf-8?B?QXFaRTFWdTA1bkdISU5iZGM5Z3JJNlkyZU9oSThIcEZyeWpTS2t2alFZRVVs?=
 =?utf-8?B?ME0xQVZOb2Ztcks4a1FSSHBzU0thY2VLVVVLNGNkL0VXNXIrcS8wSnRKSXc1?=
 =?utf-8?B?VGFFYlhHdDhZTlJjNGxPU3YrR2t3UE55UjlWYjY2YTFLZkU4VzRPdFNLQTF3?=
 =?utf-8?B?aDF6UlI1QXo2N044ZDN5UzN2T2FidTVsbVdTQkMvYU9FcDRwNFI1RG9lcFI2?=
 =?utf-8?B?aWJkSlNlQkdtVUpsbnUxcTNiMVptVnpzR0N4WFNTY2VsU3Y3SHhlSXVUYWxF?=
 =?utf-8?B?U3NwdC9ZZW5KSFcxa1FCYWhHeDBGbUs1S1F3T2JDazJsNTRPRldPSVdJanJk?=
 =?utf-8?B?VHhFck1CQnRiYjJXeGlhNXlVay9iazhtaDRyaERTNFdjbzQ2anVMYm9Rd1Z6?=
 =?utf-8?B?UlpVbDdWSU5OaDB1MUgrOUpCeHdsL1JFYjFqRG5TUVIyVElCamp2YXVCUVJt?=
 =?utf-8?B?c21rWHNDTUl4a09GTmZLeFB6SVV3YXhLV0NreWMvS1dSeWYxZ0hnYXpZbkxv?=
 =?utf-8?B?anlQekZjSTlaQVdKT250aE5rZ2g4MFp0SHdYV2dxRUJBVGZTZ29qZU1KYzAx?=
 =?utf-8?B?dGsxWlkvNkxnRmVZdTFMNkd3SC9LV3N0VURyY0s5Ujk4Um5TU21SNVhKNVVk?=
 =?utf-8?B?UHlkUDFjTE5UMmRJTENmSW8xdEloWW0wTnV3RDZqcjZuQXpWdCtjRDd2UEVS?=
 =?utf-8?B?L1VZQUJOTGVJMTNsY2FqZ2k5eFY3K3h3MXJXcE1YWVBWa01tZERPQmQ3VkYz?=
 =?utf-8?B?TjZWR29mdnRkS1RhaGNHY0dZU3hWdW03emRqTlRsa2ljbnVadlRSVXdOQXY2?=
 =?utf-8?B?R1l4Vm1DTGRhZGx2a3dmcDArMHE4bzVVZzlTWG5RbnhDOGNya1JTSEpNaEJX?=
 =?utf-8?B?UkpJR3NOdWI2MVNJaUQ1RnNXZnBLYktRRlJBcncxUzZyVi96Qml2emVrSWpH?=
 =?utf-8?B?RHlxN0JiN3RuOGlHTm55YWNSano3UlpVOUkzM0ROZFBoVzg2RDJmZ1hZNmVU?=
 =?utf-8?B?Q3dHWE9yQU5BV3dEK1VTNnBWN2thUjBBUURrcHFBSzhSeEc3TVlxakp4eVJO?=
 =?utf-8?B?K1gxUnFyLy9nUVNzSDdpUXdLVG01bU1pdjlSZjlxcWE1ZXVObXZkR2Y5K1pk?=
 =?utf-8?B?QUFlYWFicVAwOVByeEZlTnJJcjVvZW9LMy9xd0gvY0U5eHVWYkd3SEc2T3dJ?=
 =?utf-8?B?VE5keHM2UkdIK2ZyV3pLNks5eEZZanB1dEhoSndnL1pzOThIeXIrVEdRVDFI?=
 =?utf-8?B?TGdCNUpMcFA1TXlvZEdtU0dUUWUvMllxV2JwSjA4bVdUOTd0RHROWGNKWFla?=
 =?utf-8?B?QWdIZ1RKMUE1SUpiYkJNelFDZWFZcWovS2pWRjJYeE8yM2FRWGJ1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3045e5a2-4111-4dc0-4e99-08da1cc8cd6a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 21:09:59.3554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04cxLf34sv1+8lRMW/7aYuUcB//9m7iRZyCKFPlwkSgZ+CdrWx4RZiv/taowRA7K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5547
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
Cc: pmenzel@molgen.mpg.de, evan.quan@amd.com, andrey.grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I suppose I didn't quite register this on a first read:

On 2022-04-12 00:08, Darren Powell wrote:
> Contrary to the smu_cmn_send_smc_msg_with_param documentation, two

I'd just say

  Clarify the documentation to also mention that we drop
  messages and return success in the following two cases:
     1. ...

That "Contrary to the ..." sounds a bit harsh.

Regards,
Luben

> cases exist where messages are silently dropped with no error returned
> to the caller. These cases occur in unusual situations where either:
>  1. the message target is a virtual GPU, or
>  2. a PCI recovery is underway and the HW is not yet in sync with the SW
> 
> For more details see
>  commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>  commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")
> 
> (v2)
>   Reworked with suggestions from Luben & Paul
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..8008ae5508e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>   * completion of the command, and return back a value from the SMU in
>   * @read_arg pointer.
>   *
> - * Return 0 on success, -errno on error, if we weren't able to send
> - * the message or if the message completed with some kind of
> - * error. See __smu_cmn_reg2errno() for details of the -errno.
> + * Return 0 on success, -errno when a problem is encountered sending
> + * message or receiving reply. If there is a PCI bus recovery or
> + * the destination is a virtual GPU, the message is simply dropped and
> + * success is also returned.
> + * See __smu_cmn_reg2errno() for details of the -errno.
>   *
>   * If we weren't able to send the message to the SMU, we also print
>   * the error to the standard log.
> 
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7

Regards,
-- 
Luben
