Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E10DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 16:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A40C221EA
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 16:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A40C221EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287CB6E222;
	Wed,  6 Jan 2021 16:08:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED866E222
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 16:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRoXOSOq+G9md3zfWPb3tGfOBi3CwDi/MQI0umWhpOgzT2C4ovTInnhq5eoX88vrEgL1WIt7FAlSO/NuMahC9RPhKFF3qoQXRrMdUAUfDzvaDnAuAq8MFYjDyR58wHDKgc0OXX0bY31/tt3Mmm3ZJlMMwTXm3vxKWw+mIMOruadtSZTj40agcixaVMB3sp1xts0zS+vSreOuB4u4hLZK1Gj9NM9pM2xFfd5hAgXr5RoU4vF/ec4H/HgasFzhHVzJ1CB+yjJ4+VPcpXkSPbyPIdg6wrEzn1/PbqJpXEUpxp/BAe1tav+iWimpwI+r7SmDyNw1oDihKZoyccDgJ1snug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t06eHqDHVEO+o7XyY3ustjt5fN81sCPeK3usqiomAA=;
 b=iVrE+w1tv91JjYa004coLBD/3H7hvSxAoBGe1c/VB6ga/7U7S5dDkMfaa+Ij30BQQcysGuK3PgwRrBV66cPzxtiDPpu6QPKm2GVl1t90c/RtyNz+f2P57oI7qFvods+rWVaYqcbTPDhcObw2nvWB6sMUAV+XtrKp+wIhGGeiZK6G8yYO+P84/svzsCIPP7PO6nQwzhTogUX60Yg1M93hCSXQtzKbe45JIsW/kO0kMbx7YX8xJanaH5OsDvmpRDcH5/5dpvl1lYZYdQlYrRRlzradnhV9VydsU8GM7DxL/9F+11OafQiqPjyoF7Zpok8GzhjVkASt8jrxo+I/eX+YgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t06eHqDHVEO+o7XyY3ustjt5fN81sCPeK3usqiomAA=;
 b=NqtWL8tN6XEvTTr6hUuOz6kRZgVr9xlM0Nq2HyQsP0rZl8l6lAffnrnA3DJmtnwPE//JsLunvHXDOi8nnA7G5dupGe8V+FcKD4p3PZg8x8/HY5dla7QhA3OM36Ifj8fOkNiPkY90KEKWGmMYWwxwtr2IQddCy36vRUPAENvEbUc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2515.namprd12.prod.outlook.com (2603:10b6:207:40::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Wed, 6 Jan
 2021 16:07:58 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9425:559:83c0:991b]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9425:559:83c0:991b%9]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 16:07:58 +0000
Subject: Re: [PATCH] drm/amdkfd: check more client ids in interrupt handler
To: Tao Zhou <tao.zhou1@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20210106061313.4521-1-tao.zhou1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5f970e1f-5e35-c8b6-b41d-2f3dbcc15a76@amd.com>
Date: Wed, 6 Jan 2021 11:07:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210106061313.4521-1-tao.zhou1@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 16:07:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7347c21a-aa32-456c-9d8e-08d8b25d3c33
X-MS-TrafficTypeDiagnostic: BL0PR12MB2515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25158DDF4EDE64BC1FDD57D892D00@BL0PR12MB2515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTLD/ls2DHzKmIcNjVaoTzlndba9QIFvFaUjoHdrFzkibI2uK8US/xla/3lK7e9fK+JgAvXeSS/yJqYEYwkPkG/Xe2rD0a+Y+2WGZpWmymPsXr7dMGj5XW78GZO1GYfZlA8hqQb5uEHAiAz3vfF1yKAPHsgrBhwxap1Ceh7N4Ns9dvOWsl6hBz02RCcOc+uPErAGi7FvLu1zZg3BSjxhO/nr9eBpQFX794+ZZYi1O30AkTBayEJjwzOZLKR2Q6WqZDYydMBED/c4fq76ou0WAXieuDIyz1gf0QMEXl2ZfcNgKOTid0bk5mvMbbxro+YIB1SU6Z6TIw/ftgy+J8XXV1DbnR6oQJvHytVSy+lEVdo94Ht4NYdLhIaHQTTu8UCHW8zmtqgr7CHqFXtsKiVv43+IBBRea97z8RKRKtaasR9KKU30L+S9Et0edrIT17dcAFwwBsf6odFk9W622RC8GtkLTLoAmGFC/OBhuaxhuQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(316002)(8936002)(16576012)(66556008)(16526019)(186003)(31696002)(66476007)(66946007)(956004)(2616005)(44832011)(5660300002)(31686004)(2906002)(36756003)(6486002)(83380400001)(8676002)(86362001)(478600001)(52116002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?clMyQnlWUFJLN2VMcERBY3VadzBuWFJjdkttUGpONnp5WDRzN1JGZ295T3gy?=
 =?utf-8?B?YjNTQy84ZTh1aVNQTEhGZW5zRTFsb2N1Z0prRW9HcFlxa2hFVzB6NGNLZFFT?=
 =?utf-8?B?SlJIbFppRXVubjB6bDgvTHdQTU5saHN0M1RpSHprdmxpYlk0OU5JRldoZnc1?=
 =?utf-8?B?SjdZcElya1NKSWxtZnZlbEc1TEk4N3REd0FXVmRRd1F5M2VoaFFEekxCU09E?=
 =?utf-8?B?N3dTRUs0T3RsQmdTa2c3cU9vbzFHWTBKVnpLZEttWDRQV1pveXBFeHlMK2dP?=
 =?utf-8?B?U0xkWUt5NG5aVXJZVGNwMkV4OFVDUnRUK0hjTmdqT2c0WVpFT0Nkblk5Uzhq?=
 =?utf-8?B?MG8wMThQTEcrQ3NxODZHWjBPcUtNdVFOWFg1VHJMcTdwVGpSTVJ1ZHF2cmtu?=
 =?utf-8?B?UTFhbXNxYmJIbEoweThzWURSbDA0OEZLU1FJdW9ZVXZYTVVPRTlZYjd1dkJJ?=
 =?utf-8?B?bjhLTVhwMG5XbzltTlYyWGRTb0NmRXpCSTlLVzIyY0JOaVkrV0VkdmYyODVa?=
 =?utf-8?B?TW5ZUm1nb0VwSVNnSEt0Sk1DYWRrOTYxNExZLzFpQWJKcllMaUZ3ZUxLNzMv?=
 =?utf-8?B?bURhQ3BLczg5SEkvZUpDRkE1RndCODF4U0NuZDhreG5KVHVDcmhWUG90RFZw?=
 =?utf-8?B?M0JMSkIya0tmdUZIZUwxQjBja0UreE0yM0cyaDY3Yy9VSS9pNmpIMTE0R2xL?=
 =?utf-8?B?MVl0VmNtQndldXovUmJGaUlXM0RXYVhlc0R1bnBFSUtaSFVVZ21mQ3QvNk5q?=
 =?utf-8?B?eGx5SHZ5RHZ4MTkvemVYR0k4amVVWERUSG1ha2lEZnF5M3FiYlU1cmpMMVh3?=
 =?utf-8?B?Z1h5NlRpYnkzTmFYK2RDQU5BRHhIbHBuRm1JTmZ0R0VJU21WVk9WTG1RMDA3?=
 =?utf-8?B?enJBR1d5dXhLenA5UDFobThVdlBRRFFHak1ha2M3eERza3VKcTJqS25ZOXNu?=
 =?utf-8?B?dG1HZ0RnQXdzcDFxUStiN3pOSFE4TUtIamdDbVdRR2F6dURXOXRIZ0RHY29E?=
 =?utf-8?B?RTRzQjk5K212OFJrejNMczVELy9hNDBYQTZUZUo0UU5EUEdrc0wxVWx1OUNV?=
 =?utf-8?B?UTR6NlZKU2ZEeDNpVWJPV0dHdHpQZWpaREdWeUhPRStpOGgzU2Z0YTdBZHhU?=
 =?utf-8?B?aDlwVlVldXpYUmliTlhVVU9jR1BWWG5iNTNJZk1mNEh0bkwwUkhhcS9rWnBi?=
 =?utf-8?B?ZG5RZU1RQk96RFljMlFsQ3hDMnpMMVdtTlZwRnBkVXRkMFVUa09DMjBRRWxQ?=
 =?utf-8?B?L3B1bitqeSt0QVFUZFFmQktzVVhWbFpuQ00zSEJHZG40TlltYmtIdlMvL2F6?=
 =?utf-8?Q?f3pHvBc+NL5HhY1mInJLegJCjp+zN0MqHf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 16:07:58.3388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7347c21a-aa32-456c-9d8e-08d8b25d3c33
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqomRYDNRqTxnqITHsQWILXALCpZ88X3+j8gTebhYGL1HaFgUqG/3N8okOb8KExkva2EetvRZeJw/rTMmzULIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2515
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for catching and fixing this.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Am 2021-01-06 um 1:13 a.m. schrieb Tao Zhou:
> Add check for SExSH clients in kfd interrupt handler.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 0ca0327a39e5..74a460be077b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -56,7 +56,11 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>  	    client_id != SOC15_IH_CLIENTID_SDMA7 &&
>  	    client_id != SOC15_IH_CLIENTID_VMC &&
>  	    client_id != SOC15_IH_CLIENTID_VMC1 &&
> -	    client_id != SOC15_IH_CLIENTID_UTCL2)
> +	    client_id != SOC15_IH_CLIENTID_UTCL2 &&
> +	    client_id != SOC15_IH_CLIENTID_SE0SH &&
> +	    client_id != SOC15_IH_CLIENTID_SE1SH &&
> +	    client_id != SOC15_IH_CLIENTID_SE2SH &&
> +	    client_id != SOC15_IH_CLIENTID_SE3SH)
>  		return false;
>  
>  	/* This is a known issue for gfx9. Under non HWS, pasid is not set
> @@ -111,7 +115,11 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>  	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
>  	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
>  
> -	if (client_id == SOC15_IH_CLIENTID_GRBM_CP) {
> +	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
> +	    client_id == SOC15_IH_CLIENTID_SE0SH ||
> +	    client_id == SOC15_IH_CLIENTID_SE1SH ||
> +	    client_id == SOC15_IH_CLIENTID_SE2SH ||
> +	    client_id == SOC15_IH_CLIENTID_SE3SH) {
>  		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
>  			kfd_signal_event_interrupt(pasid, context_id, 32);
>  		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
