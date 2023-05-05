Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C985C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 15:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955A910E0A0;
	Fri,  5 May 2023 15:18:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4277C10E0A0
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 15:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOS6pxO2m7KsA22/CXPfJcUua0ThXe64RhP/1eYZwWRsTQh4i39GSTSnRS4ot/qmNPurtZC2ziT3NJ++fNCZFAL1yzm0D0qBozm458rpZNu8WovNLfm79dK1BnEFJvRFSjbBWCUYBqKbrxTC4OWSjpoV5co9DVOFlP/sn/lfswHgvpu4jX94tlJWxnMgyyDQekaI4xch7zpPznEYJiwubktvt+KBdgkZ+/HKzUmuyhENw9/VUOBCV/RnfrHnCu8ryCGo+ZMoBpB/N8dln5YBaKwJWZ01dEcAZQ0ESprg4I/iPKMJ2ppI3BijPC1ZASU79mW+pkJgKtpxevgD5Tphjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN5YnNSKS7iARjVaCy3zOEoOO8mQR484QcWQF/6J5d0=;
 b=J/lVhq/LEdAg5auZysSy/OC4MTRbvumO+FTWpJp4KxpHEC08K5yqR8Cfhls3ujxOnEU4Rpzf+U/0euhDVbxleHLZwtHH6t7pX5C8T3e5uAPvZMa9W0CkTQQGIQ7mGRAdFml+SXWZVPKSEDVmu2jBuXzAN1fp+bqgcPcJgEaWWNks59J+H40gUsPYzImpRQQXM8bWfqWc7tygDYZC8uisNXH+Wf68sqJd8OmNiO2DAqKdPO4y/tlyySR08X9sdrO/vqSnbbY7We9wdSl2O/nqJFB5yAK3gWPq6+FzgMp2Yv88d5wUbPFrdWlhS4ogDM04wwXHA+FZ/OQ6i08cu4VZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN5YnNSKS7iARjVaCy3zOEoOO8mQR484QcWQF/6J5d0=;
 b=j2rBW8+rVCO6JO827gh+VkepF47n66kRQ8+ceb5D2XT6q+9EpF+y7Z2nmh3JW4pKuPn0ojXXBNVWy7rNehVTanK5ovMi5K/oIbCMFGFuaotweT/LNZiREVd2511uPYR5zPmgsleNSP+VqQeGywlfdq4Dj7KKBgtlTNVzkj+gYsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 15:18:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 15:18:31 +0000
Message-ID: <10ca8a54-5160-92a6-e262-32f500f8c7d8@amd.com>
Date: Fri, 5 May 2023 17:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix assingment in if condition in
 amdgpu_irq.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230505145914.194871-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230505145914.194871-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 087373cf-e464-4aef-1cf8-08db4d7bfc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWCZZb8kvUgGDHxK0V/4wP1qru499DrjRTxAFFGIvoOEgUfbjDqXi2o2lmAnQixFR72TYKV9ptbzK3Lp9jgQSJLHeV8ykF26Zwj+1l9YewaOo24l7W5WUdlNgIzhdcYKMlFvuf322MJOGA7sBbDtZnD41z8F8L6NKkOxbsObmzLDd0n0p26cR3l3ihOF6iS39u+8LZC6ArA0A8JzMR5pei+Kt4H0jsX2bPRf/LsAxiNXW1QBXrh2FH15snOvCXTEwuGXbqhFNNJYDp8Iiw37CFpqMgWt10NHJR6SSr5ttMwPVfnF7eutRDV90Xj682zRVlSwopz+JLGMiSZf05AYoP8eGHHoiAFo+YX3tDXPXv8d91im5C7TodcNTd1PtNM8HwcffCBgxhFkykyghXnEIsCqkUS4HnAXX7vQowrLyNgne+4xyW0+xmQ1TjIekC/sv9+VyPwxw7xKXba4gbyup4tP3fQx8Qs+dZrAnoBJ2GlSS4DUXNvK47sIiignHwO/QuKlcnWI5/g7e4KPVINIasyI4WIfWYLonTl7Sp0rCtJ95e7O+eNB8tk2OKMtsait+ECp3kkQIAYvm+Cza9drq5maySVHCJVAihZIdLxC3K4tMgcPWcrhhlnP55Ic8XrvKaE7mt4KkGYwLCdvSI5clg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(6512007)(2616005)(83380400001)(2906002)(66574015)(6506007)(186003)(4326008)(6636002)(66556008)(66476007)(66946007)(316002)(41300700001)(6666004)(110136005)(478600001)(5660300002)(6486002)(8936002)(8676002)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXRTc2NRL2VRS1JDTlA3NENxWDdkcUxPV2xTT1d3MkV5Mm9JOHBvU3pMeXR5?=
 =?utf-8?B?azFkL25od01waHE5RmFTQmRETHBuZzZaakhMMW52U0RXZ2hodVRYL3dhRy9j?=
 =?utf-8?B?eDNBbUExK2RGaW53b21POXRrMlJCSGxQdUY1ZW1lNG5tZFdBV002VWZacU5k?=
 =?utf-8?B?bUdzdGNhYUl0MWRzc0Z2YncxeWFjcDh2cDlYY2h4cVhaaTA1VGdNV25TQzZo?=
 =?utf-8?B?TXM1dC84RWVLRTd3eDR2b1JBS1ZXRlBnclNmUkkwQkREb09SbTArS05odmM5?=
 =?utf-8?B?WlVXTnJ3UmZ0S004NFgwdU5XQXI3dllnbktYR1VZY2Q1Wnc0ZkNXNVlUSnQz?=
 =?utf-8?B?aXFiNENTV3pwMU9MZzVRT1lBdFlvYitFWjNPOWFRdWVSUURxaWR2U1dtSmtR?=
 =?utf-8?B?V2ZGRE8vYXArd0Q3N09zTFJobUpBWEZXRzFoVmVPWmRVMHY5Y1RnUjlCaVUw?=
 =?utf-8?B?T2NEaEhuOEErY2hVTGxqZ09SVW1iUlc3ZEFpdVRWa2xPdW91OTZuQ1JsRlVj?=
 =?utf-8?B?cmQwdWswVjJkSUxoTGxDeEhVajV4RkFxMEdxRUtWcFF1NEtTQzFEaFRFaDF0?=
 =?utf-8?B?UjB5SXFFVDczRkhncTdQUXFRWDVDU1o0SEtSWFFiUHNBVTNaM2h1Q3RwWFVP?=
 =?utf-8?B?N0NtUDUxVUQ0RFBaSzRUNGNkb3pobGNNMlFZL3dMUWxMczBWRngvSWhGUUw2?=
 =?utf-8?B?RU5PZHptdXJkUXA2bVpmeXBZOWZtL1l5R3FpZUdsSjQ5ZE5CTHZtOGZNekk4?=
 =?utf-8?B?cW1sNDJsait4ckNIZkhpNWUxekhUQ3lzaTBUVVEzTnRnaDgxaTZKUThMbklm?=
 =?utf-8?B?Q25QTWZrMU1ScjJWSXZONnZHV2VhYXo5bmRpTmhaalZHUFlZNVU1UGlkMXFu?=
 =?utf-8?B?WEduUWIydHJTQ1lTcjRSTDBDOHVpYnRZMHJXUk9wMThkdnFNVVNpRHNrbXlG?=
 =?utf-8?B?b2NWRkZJdVVtZTRURWZtVDFDd1dvSVpidXl5N2VLMTQzZ1RGdU1CQ3V0UHNE?=
 =?utf-8?B?WTF0SHNVRzRjYXJvVlEwZ2ZqRFJMRUFGTld3REJmZVRiMENNYm5vN0NNYk1C?=
 =?utf-8?B?amRLazFCVjZCR2cxVlMzMFBFRzBPOE9POWNkQXNyVnZyTWRETHM3ZmIzNkt0?=
 =?utf-8?B?RU1CdjIxWmNRdnhwRU4yb1JKazh2Mk40T3ZPa253Wmg0bkVHeTVpL0NmRGdZ?=
 =?utf-8?B?RGZBaWJTQ1B4NTBOKy9rQmpqN21jaXdhMXdyc0l3OFhlbHh4QWhYeHdvalNI?=
 =?utf-8?B?MS9Mc0hBTlFpd2hWMDZMekVSVTIwQm9jZW82SGkzVXI4aUlhV1JNejg5Vm1m?=
 =?utf-8?B?QzZJaVFRT0RxZHJkSWh5M3hya0xnTXZ0QkhJRnRuV25hNXZ0bUVKZCt6SHVV?=
 =?utf-8?B?NlE3bmNKaHkyY1JtazRQc0IxS1RsQTFHcDc1TU44WTlOM25FalJSTlRMdFhh?=
 =?utf-8?B?Z1NCK3lGUlFyck9YSFpsNndsc2NpOUErWGVGSmlWaSs3dXJLYzUyc013Q1Z3?=
 =?utf-8?B?VW5LQTJldEE1MHlNdHpJYkVTL1MyeVhRWjNtTHZseDh0aUY0SjQzdFNVbk9B?=
 =?utf-8?B?dTRkMG1TWkFacmlONjJXVDAyMW1FRjlCZmhBaEk2MkdMU0lFbWIzZ0dTRWd5?=
 =?utf-8?B?MnFwTEttd0ZkM1FVdVdKclFZc3UyY2hiSDY5Z2xnUFgzQ0JsNmVYRjlkaU0z?=
 =?utf-8?B?RDBBWmNEL2lUMzJqcVEvY0RDbW5oTTBOcmZFcm5LVFc3SkxaOXZHaDl2THdz?=
 =?utf-8?B?MWUzdk8zRHJsVHg2bjdkTWNWdEE3QTRMME54TGdmM0ZhQWR6MUtjdUNkS01M?=
 =?utf-8?B?K2cyb3JTNWo1c3BNQm41OVdiU1RTMWRtZkpXaldjcDVzaXlHRXVTOTNzcVht?=
 =?utf-8?B?SUpxTUFnU0o2SGxaa2NDT0NvVVh0Z1dzaGRsUHMyMnFlYjQ5L2ZPVkp6dUJn?=
 =?utf-8?B?d1dTWjJmZFdYQkFrQTJWS3l6bW10MHoyT3JUWmcxb1NSTTlXdHRmaUhuY1RJ?=
 =?utf-8?B?V1FmaUlVZmlxNnZJTmVGSmFEQ1I2RDdPc3gwQUJaYndJeCtjV0xnTlZqNVJG?=
 =?utf-8?B?c0pTQlZ6QTBLODdnUVB2UTlqQ0oyWlo0UzFUbjQ4ZnZYNlZpMWZLMnZPRXNs?=
 =?utf-8?B?NWcrQzlpNTFFeVpOV3hpdzN3M2dxNGwwMVdSOW45SW90UEMvYXJIaTc1bmcw?=
 =?utf-8?Q?hUAxh+g3AiFUkeo97qB5MAdP9SkD2o6rlUokndAujblY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087373cf-e464-4aef-1cf8-08db4d7bfc12
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 15:18:31.2823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNYgHhWQMNfjxWmGjBKbK9+9cfIUUfYEGygOGzPGcdmvZzanWkF6wvHuJ8y/4g8d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.05.23 um 16:59 schrieb Srinivasan Shanmugam:
> Assignments in if condition are less readable and error-prone.
>
> Fixes below error & warnings reported by checkpatch"
>
> ERROR: do not use assignment in if condition
> +       } else if ((src = adev->irq.client[client_id].sources[src_id])) {
>
> WARNING: braces {} are not necessary for any arm of this statement
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 27 +++++++++++++------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index c8413470e057..f312e8ca0015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -110,7 +110,7 @@ const char *soc15_ih_clientid_name[] = {
>   void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>   {
>   	unsigned long irqflags;
> -	unsigned i, j, k;
> +	unsigned int i, j, k;
>   	int r;
>   
>   	spin_lock_irqsave(&adev->irq.lock, irqflags);
> @@ -269,11 +269,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>   		int nvec = pci_msix_vec_count(adev->pdev);
>   		unsigned int flags;
>   
> -		if (nvec <= 0) {
> +		if (nvec <= 0)
>   			flags = PCI_IRQ_MSI;
> -		} else {
> +		else
>   			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -		}
> +
>   		/* we only need one vector */
>   		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>   		if (nvec > 0) {
> @@ -332,7 +332,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>    */
>   void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>   {
> -	unsigned i, j;
> +	unsigned int i, j;
>   
>   	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>   		if (!adev->irq.client[i].sources)
> @@ -366,7 +366,7 @@ void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>    * 0 on success or error code otherwise
>    */
>   int amdgpu_irq_add_id(struct amdgpu_device *adev,
> -		      unsigned client_id, unsigned src_id,
> +		      unsigned int client_id, unsigned int src_id,
>   		      struct amdgpu_irq_src *source)
>   {
>   	if (client_id >= AMDGPU_IRQ_CLIENTID_MAX)
> @@ -418,7 +418,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>   {
>   	u32 ring_index = ih->rptr >> 2;
>   	struct amdgpu_iv_entry entry;
> -	unsigned client_id, src_id;
> +	unsigned int client_id, src_id;
>   	struct amdgpu_irq_src *src;
>   	bool handled = false;
>   	int r;
> @@ -431,6 +431,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>   
>   	client_id = entry.client_id;
>   	src_id = entry.src_id;
> +	src = adev->irq.client[client_id].sources[src_id];

That won't work like this. We first need to validate the client_id and 
src_id values or otherwise this can crash.

That's why we have the assignment inside the if in the first place.

Christian.

>   
>   	if (client_id >= AMDGPU_IRQ_CLIENTID_MAX) {
>   		DRM_DEBUG("Invalid client_id in IV: %d\n", client_id);
> @@ -446,7 +447,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>   		DRM_DEBUG("Unregistered interrupt client_id: %d src_id: %d\n",
>   			  client_id, src_id);
>   
> -	} else if ((src = adev->irq.client[client_id].sources[src_id])) {
> +	} else if (src) {
>   		r = src->funcs->process(adev, src, &entry);
>   		if (r < 0)
>   			DRM_ERROR("error processing interrupt (%d)\n", r);
> @@ -493,7 +494,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>    * Updates interrupt state for the specific source (all ASICs).
>    */
>   int amdgpu_irq_update(struct amdgpu_device *adev,
> -			     struct amdgpu_irq_src *src, unsigned type)
> +			     struct amdgpu_irq_src *src, unsigned int type)
>   {
>   	unsigned long irqflags;
>   	enum amdgpu_interrupt_state state;
> @@ -556,7 +557,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
>    * 0 on success or error code otherwise
>    */
>   int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
> -		   unsigned type)
> +		   unsigned int type)
>   {
>   	if (!adev->irq.installed)
>   		return -ENOENT;
> @@ -586,7 +587,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>    * 0 on success or error code otherwise
>    */
>   int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
> -		   unsigned type)
> +		   unsigned int type)
>   {
>   	if (!adev->irq.installed)
>   		return -ENOENT;
> @@ -620,7 +621,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>    * invalid parameters
>    */
>   bool amdgpu_irq_enabled(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
> -			unsigned type)
> +			unsigned int type)
>   {
>   	if (!adev->irq.installed)
>   		return false;
> @@ -733,7 +734,7 @@ void amdgpu_irq_remove_domain(struct amdgpu_device *adev)
>    * Returns:
>    * Linux IRQ
>    */
> -unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id)
> +unsigned int amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned int src_id)
>   {
>   	adev->irq.virq[src_id] = irq_create_mapping(adev->irq.domain, src_id);
>   

