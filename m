Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3EAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 16:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00086E0EE;
	Tue, 23 Nov 2021 16:58:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F36CD6E0EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 16:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8HMVX8KQDttZoXw7H//ScVYo03swOsMPlvMWU98UQrdbmCLHTKzshbDw2VSepq/wg2CqyaNi3usnGxPTxV55f4LBIBJC3H8xr5tyi0vM/wtfh+MVjpbBBeATbQnL8oun0PxTQ9eLS6dXVP1EO51LgNXTa7pxaOthh85FNHxY4TPulMonYvJ9t1mhD6+xK7/mIsW61qfEwTOb3Okybu/xiz4Q65mP0h8adoBTKlcA5aFJOF2e234f7UUpXHf0ABbY5NAeKmCWE3Ru+ltDINWz0QJ7FgByzGgxA8cR9bczhhpBQBOf7B+G7vaqBXIPD1qNEr9ys8RE5fKSDfEJezxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fohSx7lbLBDmP+2zES7VOkzFDS0ZeQ5DQMCpZyIjnRU=;
 b=O9F3pUU8dM/HK19qsJjMXaaDq/1Mvg+wY9Au10jZImxZerryU0gPR7Tu9fzJJZ1D+PIXklYJ0WSUF5XciblVdj5Revzt0IrCJVDga+i898dRBge7tQFugHTZ2767k4Zi3Z0QBNR+ukHWMdsTxqPK1O1xNipsXKZsNLEFfxsysdYECrKVzLBtaMSvCP6sdvIfBgpuu1Lnrs7mtWNrRytBMz6AOJx4lOT7zCaBY/JNhNSywGWqUfPN3tV+3hn40ewnDBuyxFMmN557wc9BkcC+56USBKGFZ/SF8qj4VOCLou5NaLs89x67nrOS4kdHqsTG55C6ZI5hiVnNi/Tc0OubEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fohSx7lbLBDmP+2zES7VOkzFDS0ZeQ5DQMCpZyIjnRU=;
 b=Ut4U6Srqshwcmr/W7O4uTWfGnWfY1kHyUTgK49bWyDbzIbaDK5I18inwnIVlzXaBtgwlfQS3np80hIENfAEwkoHzvqs5EKa0VdfINF3FrFSLv+100ELtbQ73ohfFOqdTOCA4FFRkIgFet7sEYa321KzFEAGTxwpEYmEf9z+1UbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 16:58:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 16:58:41 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable Navi retry fault wptr overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123160352.21228-1-Philip.Yang@amd.com>
 <20211123160352.21228-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5cae2d74-328b-1ee6-e0fa-7ede2a3f8a58@amd.com>
Date: Tue, 23 Nov 2021 11:58:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211123160352.21228-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 16:58:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc6d7a21-53e6-4f8f-08ea-08d9aea28023
X-MS-TrafficTypeDiagnostic: BN9PR12MB5081:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5081E9BB704D1DB54524817F92609@BN9PR12MB5081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:209;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrFr5iOj6BuqneUKlMNoH39eSOVrFBFueyjzHU6ucjf8VBZcNYMJiWwNzO5CQeuJ6FQouBVBhpy2ngnBxaYYFDzA/+j4jmp+wwucJyyn0rlsZEtrALSw+LgFc94jMSQNGzQQlH5a8KTV5fWM71TJ+gABsTcVZsLtV5augOHzDivgHtQTY6nD8NdKDuXrXkIr79dPhgxReVCfYjXAJ4oABtTf5GT733r/Zgw7IRudK9mau2x6Q83H7ntxyXlMgji/o42ERWNRzdm9B5rdR2uqlGK/VZLNvFdZG93B7NCs/Fz0J3mMolaofEAPMCLqmB7NDn3xQbtdJmqFcQh1OmvRro60r4xcgXRkZdbjlmrlCi7GJBKjR4TcWMD20lN4Ljr2Q/qIoqFcEomoL7k4tIh6bjkThqyCUDk7HpfY0Pxr4ZEH4x+dH6Lp5EVym49svRdQjxJLJBqGhPywajIhMjXcDGZmFsS0CWbpN/9DJ1m/1GgnT0yEkTAxqnxZlfSOrn4Z8LFrMh6HYkMjEtfw4MWrHTRZ29lB+LuCQP+ibRylTpHg9UWTFp1Lkt9Sx8uUmgIuqRxtVzVcQcTi9TtQh7fopwJHOmRSwDC+77Z0X023kLgaibg0AXAzdr5cQ+Iv42xWeCKb5hacf+TrD83uc5AeGAsKFYmLHI4hfMdC4jUFBBKz3yQRcwY/PuLv7KEFpTYXuokj+cuk21OyCd6mMMXihhSJ8ohy2C0bvUw4x4EhkUuU6Ame20sGUf9sMOJee55Bru6lO9qCPVuvPtPu9FOWSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(4001150100001)(508600001)(26005)(86362001)(8676002)(16576012)(2616005)(956004)(31696002)(5660300002)(66476007)(66556008)(38100700002)(83380400001)(316002)(31686004)(36756003)(186003)(6486002)(2906002)(4326008)(8936002)(66946007)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBTbUk0MXhEQ0VBYVlyaytsWTN1VVMzeWdNc055d0NlWEFUSS9PMlBkcmN1?=
 =?utf-8?B?NWM1MmZCVENubHlEYWg0STNlaW9KaWpMRVhxVlVhWnZ5Ulp4enMrTlpYRG9u?=
 =?utf-8?B?RW55bzZFS2FZMlBiNENSTk4wMDZTbmlSRkg5czBSY21NbVFIbmNOYit6R3p5?=
 =?utf-8?B?ZTBwMW5Wc2VnQmczLzdVYXVPaWp2N29HbEpIQjlsWncvL0xTREF5Y1ZVMHFm?=
 =?utf-8?B?S2hWcmU1cFV5ejdhSEVGUXRPZmhNY0dTSnZsK2pOaDJ1MHJkMkk5dkRxTjdZ?=
 =?utf-8?B?YmNvRGNRVVlOcEx4QXRNclRQRVRaeUxtWTRab0pRTkNsNlZ2Z3JScFFYOUZH?=
 =?utf-8?B?ZTVkcU52NFlhY25GUENKSDVFeU9vR0JmSTRtdmdlbG91VHdtSEJUN2xyUkpl?=
 =?utf-8?B?cTgxQ01FSjR3eExSN2Exc1dNbjB6dFA3QUNta2VxOGV3aERBNkRmR2kxZXhT?=
 =?utf-8?B?eTJxc3pTalVjMFdITWpuU0d5d3lmckZwWXgxeEFXU1F6NW1CNWV2NDRTemxw?=
 =?utf-8?B?UFM2MFdjZGhBUWo2SUo0QSs4dVpLWTBXZ3NkNnIzNU5KOFM0SmZxMDN6UW91?=
 =?utf-8?B?TWhxM3l3MEZtU3l3MTB6SEdGQkQ1TGUvay94MkJEVmZSYnoxNXIrL3N0YUla?=
 =?utf-8?B?QlZBdE0wOUZjSmwzWWtpTzd6OURQbzYzWDZmVW9taVZCUmVHVmMrcm14TVdK?=
 =?utf-8?B?Qk5zKzRnTmJNWlVoRi93ZDhtMDJHc0U5V0JUeHdWZ0FOQWxVcFFPaUNPbk1r?=
 =?utf-8?B?VnByMDhDbzI1U1N3MjFNWElKak5yMVd3SEcvTUN4b1BYU0RtN052TXZYcVp2?=
 =?utf-8?B?QzFZYUg1eDExV3ZWYzA0YllkTGZySWNVdEVYYXk1Tjhmc01WNmo1Z2VvSC9k?=
 =?utf-8?B?RE56WVNjRWYyZXdmUTk3UUs2RWV3a3NsZ2VxZEhib05udHZRWHA0TnJIKzZ4?=
 =?utf-8?B?Ym8wd0pCOHNCZEc2eHFkdnIzLzRNM1pnaHNJRFc2dkR0T2lPR1VGSzFlazJy?=
 =?utf-8?B?cVhkVEFELzdYTW9RdTJCbm44N3dIZ0dlS1FuelEwemxjUno4MkJOVjBSc2Rt?=
 =?utf-8?B?a2p4NDYrTlhuZ2dmK1hNS2Z6M0YwUnZzNWVXSWZEL0lHcEdISU81OHB6bDRv?=
 =?utf-8?B?Z0N5cnRPZlRscTN5d1FTbkVhcTdOc2MwZVU2dHJNVXFBcXFyWmNyU2x0azZn?=
 =?utf-8?B?MFNTeWVJQUNMa0hyaW1wQlNCMmw3MXJZUGpKU0g3VG5kcEJ3RzBBRkFzcGN6?=
 =?utf-8?B?YU9saTJYQW9Ka0V2OVMwNTlYYnUvUWZvdnZuMjJORi8vUFJ5ZWJTWWJJVkp1?=
 =?utf-8?B?UHNobFIwUk1WU21jNHNQSTkrZGRoQlVyVlJnK0Q5VEMzbWxqeVR2ZnIweVVr?=
 =?utf-8?B?SWJCdEZJbzV2SXMxOTJTdFd5VlJXWm1zblg2c095M09ndmFhanorTjhsZE9R?=
 =?utf-8?B?SXM0ZFVZNVQ1bmVvcEdvaWI2dW54M3lwY0ZiMit2blV5Q0tmQjVFUHdCclho?=
 =?utf-8?B?TS9WMHIvQWpINXBsOVQvRzhtTEhTbDAzYVZMcEVzU2FvdnArY0xqMkNnMTlV?=
 =?utf-8?B?RlQ5SUVmTmxqbmdxY0Z4SGlVbUoxeVBFL0RrQStkdUpqcE9iYmdvNVUrZkx3?=
 =?utf-8?B?bFdabDRKQldhRExmbUQzL3JHQXRkOVBJR2hySjIzVUNHcCsrZkFxTFE1UXVD?=
 =?utf-8?B?bGVaTzdrYXFvY0J3ajZIQTE0SWRIa01GVWlGeld4YTJxbGVPUGJ6WGtQNURr?=
 =?utf-8?B?QUZ6NFdHY0toQklpOXVOZFpyK2o3SGZ6N2Y2czBvekM4bDFyL0xoYzc4Um9R?=
 =?utf-8?B?VkdlSnluckhtdU02b2UwVVo2Znk2OXE2TlkyWlB6alIzWEVHRmx3YXNIQXF4?=
 =?utf-8?B?OEk2bXp0b1pzWlVZZHRBRlErTXN6RnNwYlg4TlU2SjRTMTliK2dNWm4ySnpM?=
 =?utf-8?B?ZVdsdzMzMWN6SU1NNGxKTHYvYU1Bb0U5Mjh4RjFsZVgybStiWlBZK0FXd3o5?=
 =?utf-8?B?S1IzS050SmxpbkNNWjRhQUZtd1EvUFVqMDE2bjNHaWxMSnU2NFFlR0hPUUJn?=
 =?utf-8?B?b1hDRk9GOEdrcVptNWlDaGVJZ2VKNU1Wbkp3b1YyU21OeHUxZlJQYld0Z3ZY?=
 =?utf-8?B?MVJETWZmdDVsaUJ2NDVYRUV0eisvaWNsdjJBZVo0ejhxZDYvRFRVMk5tdkJV?=
 =?utf-8?Q?RU6CyADV9ZDLOX75BCCXdVI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6d7a21-53e6-4f8f-08ea-08d9aea28023
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 16:58:40.8346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfL+rKiMWgCN4qL3ULYjScDk2Jj2XspAdeTMXSxoISiBVneCqnfAlrYcDSKpUtKhF1Fe4sFdIqVqaN75wqNBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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
Cc: alex.sierra@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-23 um 11:03 a.m. schrieb Philip Yang:
> If xnack is on, VM retry fault interrupt send to IH ring1, and ring1
> will be full quickly. IH cannot receive other interrupts, this causes
> deadlock if migrating buffer using sdma and waiting for sdma done
> while handling retry fault.
>
> Remove VMC from IH storm client, enable ring1 write pointer
> overflow, then IH will drop retry fault interrupts and be able to receive
> other interrupts while driver is handling retry fault.
>
> IH ring1 write pointer doesn't writeback to memory by IH, and ring1
> write pointer recorded by self-irq is not updated, so always read
> the latest ring1 write pointer from register.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Looks like the same thing you did in this commit for Vega:

    b672cb1eee59 drm/amdgpu: enable retry fault wptr overflow

This series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 33 ++++++++++----------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index dafad6030947..38241cf0e1f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -276,10 +276,8 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
>  	tmp = navi10_ih_rb_cntl(ih, tmp);
>  	if (ih == &adev->irq.ih)
>  		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
> -	if (ih == &adev->irq.ih1) {
> -		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
> +	if (ih == &adev->irq.ih1)
>  		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
> -	}
>  
>  	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>  		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> @@ -320,7 +318,6 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1, &adev->irq.ih2};
>  	u32 ih_chicken;
> -	u32 tmp;
>  	int ret;
>  	int i;
>  
> @@ -364,15 +361,6 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>  	adev->nbio.funcs->ih_doorbell_range(adev, ih[0]->use_doorbell,
>  					    ih[0]->doorbell_index);
>  
> -	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
> -	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
> -			    CLIENT18_IS_STORM_CLIENT, 1);
> -	WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
> -
> -	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
> -	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
> -	WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
> -
>  	pci_set_master(adev->pdev);
>  
>  	/* enable interrupts */
> @@ -421,12 +409,19 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>  	u32 wptr, tmp;
>  	struct amdgpu_ih_regs *ih_regs;
>  
> -	wptr = le32_to_cpu(*ih->wptr_cpu);
> -	ih_regs = &ih->ih_regs;
> +	if (ih == &adev->irq.ih) {
> +		/* Only ring0 supports writeback. On other rings fall back
> +		 * to register-based code with overflow checking below.
> +		 */
> +		wptr = le32_to_cpu(*ih->wptr_cpu);
>  
> -	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> -		goto out;
> +		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +			goto out;
> +	}
>  
> +	ih_regs = &ih->ih_regs;
> +
> +	/* Double check that the overflow wasn't already cleared. */
>  	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
>  	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>  		goto out;
> @@ -514,15 +509,11 @@ static int navi10_ih_self_irq(struct amdgpu_device *adev,
>  			      struct amdgpu_irq_src *source,
>  			      struct amdgpu_iv_entry *entry)
>  {
> -	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
> -
>  	switch (entry->ring_id) {
>  	case 1:
> -		*adev->irq.ih1.wptr_cpu = wptr;
>  		schedule_work(&adev->irq.ih1_work);
>  		break;
>  	case 2:
> -		*adev->irq.ih2.wptr_cpu = wptr;
>  		schedule_work(&adev->irq.ih2_work);
>  		break;
>  	default: break;
