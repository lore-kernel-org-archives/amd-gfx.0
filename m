Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE5C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 07:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1878B6198D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 07:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1878B6198D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B305289998;
	Tue,  6 Jul 2021 07:37:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CA589998
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 07:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdhWpUk/5wvzhteCxKrijQ2du5CSQXi9jfK8yFUSpxbfnLV3+KTCH0XI5N5AStxK9cDcFl6Y49ttGBLNs1b9XEzrzL3h18U7LPoikogZ9h1DU98+v9Dn7qVuBt5VttPc3hmkZsmQozJVM3uWhbnjNOcs0ZefUafXDegW0pemMwRWpTXYpBBNdBkqdO0kGrh8CZmv20ZQDNayx+QXOC+HBVjlcim3FGY7m38uw1CDaXafw9GiPvYU0exOcHBb7zZZoLWvcBZ5PkWBht/W+eg7dfIP37TLJYX6WrV79n2wxztPwL/6EqWP6okkkXtFPAvCrozBOvhztf7zQ58sUEzK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4P0ttVAdsWuKlqpN4hWJJMwC+tP1/khsHsmU3TxADE=;
 b=X4JiZg7pg8NwTB5MSQ9Z8Lmn+8Dh6p7+EzD40lvCRTnC6wH6aHtdh9TqIHWhwebbX6MCBzGfAYjzkaUA1q5rkmKHr3Qujk6+Sjwlt/ekN012h07YXqo5h4A6uWcgS/MoOTLvgNERcHNVLhFjEVFPRTQOPI7J1Igd6liHKj5BwVZNhyrSiYghl5qpExad8tO0EvhpL/qa5pZIwcsZxorZedVeZ8EL3bj9aJJbKHNFO99JY5CTHgqvfKFUQ59S7Q96A/xuz+IvAk3a+dza6vxROsiR76mqktcpWnV7k84L+hxwI5UGp3eYIZEeYDm3ssrXyhIfdmSpht2jxrihB44NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4P0ttVAdsWuKlqpN4hWJJMwC+tP1/khsHsmU3TxADE=;
 b=O53vmTB0P99IDbbKmksRYTKwpSMAgUIXYX4oCBS5XpdmqzDyCM59b/XJK379FKl0rmeTj4ItjYl35Wt+KwyT9h4yDnEpuT+y/rVik9LUKABp91TBCAg6kiqpSMeOQpjUKljqeIzEyKIUBETFaP8tjj/tLRaCM8zaCRU/YS04VB4=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 07:37:01 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 07:37:01 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: SRIOV flr_work should take write_lock
Thread-Topic: [PATCH] drm/amdgpu: SRIOV flr_work should take write_lock
Thread-Index: AQHXbiALslv+2KqizECj9AYYycjRLKst5vaAgAewIHA=
Date: Tue, 6 Jul 2021 07:37:01 +0000
Message-ID: <BL1PR12MB5269FBD0D75DAF5881865B1E841B9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210701022256.763468-1-Jingwen.Chen2@amd.com>
 <20210701101233.wlskqc2kjzwhiudv@wayne-build>
In-Reply-To: <20210701101233.wlskqc2kjzwhiudv@wayne-build>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-06T07:36:59Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=be54ae76-f9ec-44a1-8838-cae8422a11db;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b622e601-6866-4fa8-a521-08d94050d7e7
x-ms-traffictypediagnostic: BL0PR12MB5539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB5539A56357005D96162880CC841B9@BL0PR12MB5539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DnWL+4+UPYO2cBgkHgWc/WF/Q0xXhbOtZ6vutpvUotr7TcfFL3Q3yY6oTnn9N8lONoXth8rjTPTFhvLgoa9auvEeuuYs42FqYWjZG4kr5JMhvpfIzCE/bebBThzVYWrQuYUB+dV/R5kI7qy2bfvhXA4NhbsWjUu6sgGSQDeQQ+OJM9PmTEYQ4N9/o+CV0A3DPc1pf3rBV+CPHLQQN7HI7lP8A9GHJPdnw6THDZxW55BJ0JH4GdqiAhSoOZWZkR1XBuOr4OWLCevKZv2Fm8kk4O2umYBx1SiXPU0mB72+CmyGObvJaJxMkqLwjQd8HtNVr7EeVXY/zCXR942VQfd3ximAFk69Vwv22LqnQDu5ERVNhCJQiehVn7hszI2N3kspcZCQomeA9gKaolhCl3A/pQzJk46IA3AmpRkcjC0/eXQFQx9tPbDQFrAbI+O87W9YTBdHe6ax40dshy2E+Z5i5QIBzG2p4XIbw3x/Lf2tUcz60lD6rFhIbh78VMLocNGIfEuHVSRKSNbjieigitOAF71CsFvNXGKVggAVTwVYcJgghFernGGGIpAaRyh162KUmHWgDSLNusb7tDfyhvk80CKeNyDozLUPAkEceWu62whlR8buHmJIkf9q2rezLQUn7KQS7M6nynbay1tqy1bFLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(26005)(71200400001)(86362001)(8936002)(122000001)(4326008)(5660300002)(9686003)(2906002)(66476007)(316002)(83380400001)(478600001)(8676002)(76116006)(52536014)(38100700002)(186003)(7696005)(66556008)(64756008)(6506007)(53546011)(66946007)(66446008)(55016002)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?POu6po24KImPNYP2f8YQZaEYFWIvksO3EFAiV8Kvpf2+yP8UO80eBooYOLmb?=
 =?us-ascii?Q?7Si0yexYkThZ2pvN94OuGMSp7HLmjVfZDu90OyYdTDaO5ZQRNaRRDEkC9nP5?=
 =?us-ascii?Q?bwo59VxxKrenFU7wAI5L83+3YMalSRErQLIdAPbDd4LjvYmtoF0w5XYe06gr?=
 =?us-ascii?Q?WRztu6faYgjbDjmHnETsoKn43sanYbTN0oOxiyHRPNoSzxymfuNX0srOx9Lt?=
 =?us-ascii?Q?igY96zG7mu4AX7L8Z+nRfcOTALsAmpEmU9pLYrxj1b8suZfCLNqzDxv2zo64?=
 =?us-ascii?Q?lD9RqYMXhU1NoF2CQJa3fDVVLOusY3RjBR9E6X7gcTd3S0+omMFcCs0P7hr5?=
 =?us-ascii?Q?ocPNFH8sOdIAeVF9L3xozHvwIJpPaK6Hn7SmVOZaC9kwbye2i27xqceThESs?=
 =?us-ascii?Q?Vw7oWIg7nhwJFe+MUeY5U3Zi0eHRQolCgqn0B8ID3Y991gtUYFJqP+b4AwJK?=
 =?us-ascii?Q?KBSXqJ+uXpo7YIiqqEbX6Wr/8r8YaAORhjtB/h37AcCxLlwW5tKix4f0piUF?=
 =?us-ascii?Q?9M1+yUhYv7CYKPoqPpVKWt2XTMlm+7K7JAdRViGixeWtMuPEz4FsIgGFTP9f?=
 =?us-ascii?Q?rM9yPjJbd7WCHAAT3lAsPkMesoWBeznYlRCxY2ht2q+lAkySJCdO7q24P1BR?=
 =?us-ascii?Q?L9775hHXz5dwvy11fwV1hAQvHKXKDerhlVZ2R/HUreZy6F1yiVQvyUGgFYBf?=
 =?us-ascii?Q?9FD+hUp3ANkmdx/grvRYjkGuBEMEuavkMB2sNz9LMCr6lufMRKEvAXir+3VA?=
 =?us-ascii?Q?t9LmEVOk2s8tek7V3LRrKuBSo9oAdIjCY9BEaNuzjGyvQOsjZHE7ZMIwsIaG?=
 =?us-ascii?Q?ZsJ8b8V5ivFsf1Y8TDTujcPecUd+C+Lh8CLZK+7rAEMpzq98JMmVOHNmU0sl?=
 =?us-ascii?Q?qd+9a3/w8gK8wrP4AeFW1akALRiNumtgtvPu4a/06jbgfoI2NMOBzK26gtbt?=
 =?us-ascii?Q?o8Ukg3mk2zF74vPcyRcQfbum/hJGyVic00FBpfm0rf7RN9wIozMu3TQx4Pyw?=
 =?us-ascii?Q?vZyzLKEQMitE2IRba0IhHoeepdjubyv8/6B/8D3AhuM1kTS22HFLiAQAHYTh?=
 =?us-ascii?Q?1ToJsnxzALJ4iOqroYCZvAwKtDaE8rnI8G04SYVYfLpudXnNmyoeqlWdOl/1?=
 =?us-ascii?Q?QEr6OsDKk86gXEysqu8r+gowmA4cmHhgKJsJqPZUuC5q0jd82PZr/+ifVmBV?=
 =?us-ascii?Q?DFcxVbbLXJs+z6QzlkGyX23euVDBY6HOalTilOK0SafjLK/yAXjlvIVGovHe?=
 =?us-ascii?Q?c9ITt8LJh8z/RcHHUp3PSdwv5sITYIF4/PoNZiDgFhRl7yHq7L3EN0+yHN2d?=
 =?us-ascii?Q?4NiXqgoeRqkJL7c9+wYBgC6m?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b622e601-6866-4fa8-a521-08d94050d7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 07:37:01.2723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: saGg7nIk1AAmWuyy8Z/e2cgk1PEl2iPiWL4eGB+/pwtR3o1poKhFQ6VA0/8+8hbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Mon Liu <monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Thursday, July 1, 2021 6:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: SRIOV flr_work should take write_lock

ping..

On Thu Jul 01, 2021 at 10:22:57AM +0800, Jingwen Chen wrote:
> [Why]
> If flr_work takes read_lock, then other threads who takes read_lock 
> can access hardware when host is doing vf flr.
> 
> [How]
> flr_work should take write_lock to avoid this case.
> 
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 4 ++--  
> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 3ee481557fc9..ff2307d7ee0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -252,7 +252,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>  	 * otherwise the mailbox msg will be ruined/reseted by
>  	 * the VF FLR.
>  	 */
> -	if (!down_read_trylock(&adev->reset_sem))
> +	if (!down_write_trylock(&adev->reset_sem))
>  		return;
>  
>  	amdgpu_virt_fini_data_exchange(adev);
> @@ -268,7 +268,7 @@ static void xgpu_ai_mailbox_flr_work(struct 
> work_struct *work)
>  
>  flr_done:
>  	atomic_set(&adev->in_gpu_reset, 0);
> -	up_read(&adev->reset_sem);
> +	up_write(&adev->reset_sem);
>  
>  	/* Trigger recovery for world switch failure if no TDR */
>  	if (amdgpu_device_should_recover_gpu(adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 48e588d3c409..9f7aac435d69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -273,7 +273,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>  	 * otherwise the mailbox msg will be ruined/reseted by
>  	 * the VF FLR.
>  	 */
> -	if (!down_read_trylock(&adev->reset_sem))
> +	if (!down_write_trylock(&adev->reset_sem))
>  		return;
>  
>  	amdgpu_virt_fini_data_exchange(adev);
> @@ -289,7 +289,7 @@ static void xgpu_nv_mailbox_flr_work(struct 
> work_struct *work)
>  
>  flr_done:
>  	atomic_set(&adev->in_gpu_reset, 0);
> -	up_read(&adev->reset_sem);
> +	up_write(&adev->reset_sem);
>  
>  	/* Trigger recovery for world switch failure if no TDR */
>  	if (amdgpu_device_should_recover_gpu(adev)
> --
> 2.25.1
> 
Best Regards,
JingWen Chen
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
