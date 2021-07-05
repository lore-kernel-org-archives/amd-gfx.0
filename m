Return-Path: <SRS0=ZRVW=L5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFEC07E98
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 05:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3070F613DA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 05:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3070F613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A934F89C80;
	Mon,  5 Jul 2021 05:51:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03D489C80
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jul 2021 05:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB6WxhsTkumWvAmiUHTPkWP1cjukWZLNVK2yeZ3DZAE16WP04whHg+6JLkxVgw8HpOJfPMehJe2y+OhYADwwUQxv+u7kPyNMgxkIwcalHzhpiNcrAKAuhznRRDVeGHkWG3pkYnxmjEnusvX+TEgf8alvgZir/QmSj2zSNVUtPRxOJb+DGOqxHfRwRmMNI1XiEHoOF98+PlwjhgjQbVJZk4vfDOAscj6BHYxoxC1x5N2zHfgBsKl8n8zmr0otvhjVlcaCMhAy/77KXXDH+44WsUEYW083GelfMNCp+rxz9rWQoyw2rHZKfOIykxviNHXC+uF5Yj1wtiINWOE+oPHI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8A61cHGTXO3AXs4Umd+RMz5sRsmjTwW45KU6TYUOTg=;
 b=BB0osqPlEPlMX36oaVorbc1n4yerS+HoiLS5fvXB8BfM6wQ0mhe3t03L6QhCGzhmLeYyZRP8/0hJcu9sSup4xtSitElaJoIdbGL4IjHt+Z9YebMwWP6CR4kh1+vmyWpSCdxDxkyET4O0foHMKowVj25t1YQO2YWemtov8lgIrZS9qK2KcfPNDTUpRRY+g52YeuDVve9+wJraorYPbW4mpRMvAiCECElDF1huW1hipZarlg8gL81nrpAhKXQg9VHZGFr7xfhAadfneAtonPizy+o7fcTbia0WUWiReswIo+ghUe+a2vm5RxmRa6DaGkEyXVa9Bb/vV+yzuP/ZgvtwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8A61cHGTXO3AXs4Umd+RMz5sRsmjTwW45KU6TYUOTg=;
 b=tYUENJ/bGJSuIO4V+roknGXjB9LskfPSd5vTpCL/YxJxXXsrKE4NxMPL7mDi0ap5fIRAyxp+e8qCNDY9ZG/350jbHBohdg2QW345ZsuGSrMZuaM+BB41EAhbnz1FUbPxRLh/VinK5JgxGmdXGmoUNaBuLAS8Ui1piXUf1m1MH/Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 05:51:49 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%7]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 05:51:49 +0000
Subject: Re: [PATCH v4] drm/amdgpu: Restore msix after FLR
To: Peng Ju Zhou <PengJu.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210702032318.27215-1-PengJu.Zhou@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <5a48ef83-164e-8203-8945-b5dbb1ce9ad6@amd.com>
Date: Mon, 5 Jul 2021 11:21:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210702032318.27215-1-PengJu.Zhou@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 05:51:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3257f866-23b1-4780-ab66-08d93f78faa4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5156:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51565AFB5B8442DD1AB59C56971C9@CH0PR12MB5156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1WS+t3CoyOouISa4RdI+lYCf8IjtIXrRSy5+tdQM1/h7EciGQwu++TrN8rDy7BGx00YKCql1L9XhqC2/aFbpHZOjOQxlyFLuhPpOIk3/I5XQ04J0SCdCU5/NCAr93gZaJTfICyHi9Wj9w2+DLQUtSpCkMl8/PrYpDbrgnNUNhzU424LScjAu9IxxprCJpFLspn0Lc6C1GFAXEkzF1czcckxShRxnAvdH28vIIDpf+U6n0x/GG3XF1GkoSPAWjDHST+VjH09ubVBABehqNex4yfp8yhXx+joCGpbw+5N+hsImS5cOPk22VH9k7ma5rwJIZq0HAIO+9Ph+xe/1Q8lG2A7eYdLls0jqIDK/9fhrg5D2qca8lAlqlelbNr+4Csq6axYCibSG+H9/gIyPm9H/Xw6QlZ1jSIXvU/Vsx3h16D8vImsvn7CTniZcjfpE6nzbPGJCTpQLBIqRdYisX6gyyW7o465UvDI0IddxGa/6tO6O3YU2tJTCt7yyazJ7JCwrPhKdeIg9NqJOtXipRMwHp7+TTGPMWdCLWivHkppCT2JJvbigD5VoRdA8ZyEpPViqd6dqwejWoKgPFBWQbIq6lHkIfXD5ROjJZDCtSmFoduojub/Bu4OtZB0SWIsWhCucXHp6mV/oEh79pF41g2vG6OcNwSdGb8sSrzDZNifNKUDXZK1X3rMif/oCaxS4d5VlprPp3o41jp29moi8BvTamFNO2KdVPiu9Z89LyykDzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(86362001)(4326008)(956004)(31696002)(2616005)(83380400001)(66556008)(66476007)(26005)(186003)(31686004)(16526019)(38100700002)(53546011)(2906002)(478600001)(8936002)(6486002)(316002)(16576012)(6666004)(8676002)(5660300002)(66946007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUN6WVY3aEhOYWVoQ3k2bmhqakNIdjhwMWhoQUtuRllrMzNnVGFKNHYrTnRi?=
 =?utf-8?B?Y0FyVVpWYytYbGNTb0lYcHYyS1MvYjFxMU55bnJBVUVidHFDdUo0NWIvcWxR?=
 =?utf-8?B?THhkRStwZkdQclVpaDdBOUlVOWFSVFdxOUNFaHBVdEt5cGFyaDY5ajIwWjRw?=
 =?utf-8?B?UXJFY3RNTHlMclVrT050MkRhRXJ5MkpsZHVtdlpYMnhEQ1pmS2dDUWpGbjdV?=
 =?utf-8?B?ejFYQlFRVERydy9YKzRHQXJVUGJZZVlRem45VHhUNXRGNU1uS2VEazFrSnBH?=
 =?utf-8?B?b3gvOHQ0ZG5XUVJvSFBkT0wrWTRWRm90eTJSS01icnp2NTJWd040bm0vczd4?=
 =?utf-8?B?R2MrdzF1WVY5TGRMR2dPU1hFT2dxdlorVlQ0TTA2THNBcGpEQSt4dTBZcHNq?=
 =?utf-8?B?UFVIczJOU1piWW1KTEUwNVVTVmpVaFdRRFNoelo3dS9ZKzZoV09HUnZnRE8w?=
 =?utf-8?B?eEhGd1Y1UUc3TXRIY2p1R213MmdYUE1mdzZlS3RjZkQrOEgzQWd2V3NwV2NH?=
 =?utf-8?B?RHpxendkemhQcDA1TWRZbGtjcHk4dHluaHVYSUR3RXFqQkpsTktqbGNjQXhv?=
 =?utf-8?B?OXh3elU2OHNtK1YrUEdQNUFaelNwb2hscS85L2s3RG1vUXFwbW10N2pxbVg5?=
 =?utf-8?B?ZzRrVnk1dG1RcWEzeS9IaXNKY25wTTN1Vm93M0pQZ3ZTRkd4N2U0SE5ncHhQ?=
 =?utf-8?B?Zjg0UWVKSkRnYnh4WGR2M2V0Y0Erc04yMHoyQ3dlY3RKNzF1VnpSTVpYaUZx?=
 =?utf-8?B?Z2IwWjREUkNyUjJVSUZvRURLTkYyenI3aW9uOUh1TGpVeUpqQ2FKQlNXN0la?=
 =?utf-8?B?U00wSW5MRGd0OUhnb05ZMnJMWkxHRDUxcnZkVHk5MG02a1pRUkRNcnhPMEVW?=
 =?utf-8?B?MDVKdnNOdkh5QzMyTmtTdjY1U1MrRjlOcVp0QlRBRzRWUjhDTEczR0JrSjlK?=
 =?utf-8?B?Rzk0c3g2TWl0QUMzQmhMUk9UNVZYek1yZ3VFSXRqUlh3b3pnTXRVQ1Jvd2R3?=
 =?utf-8?B?YmFKeTNWbDNsNC9jc3pUZWtJZ3c0TGFpbDd5MVB4V3N6Rk90aFRvQW4vWGxS?=
 =?utf-8?B?NkJXVWVoclVzQk84cng5VERMNjNVWGd0aEZ1dUFONnlIM08zZVpZVVZuVUlR?=
 =?utf-8?B?YTVMNkFxMGdDUDc5OVFDT2FQQm4wSDdRRTA5eWw1bU5MM283cDNsTFczVDdl?=
 =?utf-8?B?anJBWTlicFk2RzZiU3FuZUNYZU9GaGt5VGhTOGw0bHpOK2NUYmdaaUkxakMy?=
 =?utf-8?B?Vkc4cUhpcDNGN0lZb0hmaDRvVnk2RkYxM2R2c0FkUk1qZmRsVklKcmVrUzdH?=
 =?utf-8?B?UjI3eXpacUh1ODhPeGVvSGpRUWZ2a1RXWEUrcHRlWXhOZlo1WEZFNjJFM3l0?=
 =?utf-8?B?Tlh4MXNFNVVXNVpFM1BmU21jcWpyUjZoZWlHYlR2MVo5VTRPNjd6dnk2dWYv?=
 =?utf-8?B?R0hQWXRwVFhraEpVL1RoKzE3MVJjMWZqb1BvVzJNNXdYUDZDODQrY3ZuNlEz?=
 =?utf-8?B?TjFEaGl0YnpYV0JNTGRIZWphTzYzMWYxaHA1TmNDY2E2TDN1cGUvWjZVSGFO?=
 =?utf-8?B?Zlh3TGh4SlV3L3J2NGd5UFhGY1AxbzlOdGEyV01neDlxUCtSUkU1ZHJQaTJC?=
 =?utf-8?B?ODRLZXNVOVRERFFLSEM0NDc3SWZRQkVPcWZYVlhCLzBRZHQ2OTBTLys2eStU?=
 =?utf-8?B?YytSLzJnWG1DT2ZBUVZPYmZDdjZVMlNPcHl5UkMxaTdBMWtYay91NWI5bDQ5?=
 =?utf-8?Q?KciGiGe6ee+uvU+BA3x7hJuVvBFcM1kUBFHvKOh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3257f866-23b1-4780-ab66-08d93f78faa4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 05:51:48.9609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjZx6kBAne2hK3CEn2p8Uo3k3UegpYKZQRJjMfyYSxOia89AjqRaaD5UjdI9R3Gi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/2/2021 8:53 AM, Peng Ju Zhou wrote:
> From: "Emily.Deng" <Emily.Deng@amd.com>
> 
> After FLR, the msix will be cleared, so need to re-enable it.
> 
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 90f50561b43a..034420c38352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -277,6 +277,19 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>   	return true;
>   }
>   
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
> +{
> +	u16 ctrl;
> +
> +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> +	if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
> +		return;
> +
> +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
This field behavior is determined by PCIE spec and toggling is not 
required to enable MSIX. Also, FLR will clear this field on PF, so the 
ENABLE flag check to see if MSIX is already enabled doesn't make sense 
for PF case.

 From the code logic, a rough guess is this code is trying to reset the 
VF's config space field in PF after VF FLR and enable MSI-X back. If 
that is the case, make an explicit check so that this is only done on VF 
devices.

Thanks,
Lijo

> +}
>   /**
>    * amdgpu_irq_init - initialize interrupt handling
>    *
> @@ -558,6 +571,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
>   {
>   	int i, j, k;
>   
> +	amdgpu_restore_msix(adev);
>   	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>   		if (!adev->irq.client[i].sources)
>   			continue;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
