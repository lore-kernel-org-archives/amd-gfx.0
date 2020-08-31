Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E87C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8C22067C
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QvIQoNwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8C22067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC396E418;
	Mon, 31 Aug 2020 21:09:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E63C6E418
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 21:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3I6QJxONldPvtI+f3UBW5xT67I8KfcISz+ZF0ueJnyGYvaNjM+5Mvo2nBV3BK2OmBbPETSp59WZ2vHuJDnfZn318MgXdgPDygVGpD186NSCwGbtHh/Ko5+CUAjI+sMO/fwhJjbUseimFY24h7X6MX53Tbo6xGf0I8JTxE4lTteO/BEJUlgLkLgQcozEx0tpXvjKJK+uftjbR+snZ9xgO+OVIrpZa8vHewULGrtt2X2ATzVB5l7aa23W03drtGUdOYWeLppQRLmFoYYXeaiLEbdbn+2VO/o2KVG787yUHxeTeyUiXAn04lK2D8jM/Z8dS4NzDy3Y6NrHEG8UV/E1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGMmeNTfuUssPiy8f126PDQRZxn98HerjykqpUm5ajI=;
 b=IDfoKmkS+7IdYLdec00ojbBlaN7UFPXj2OaanOOVt53OzOMTHSXU2olXoZGPVX95NOsBz3QiMzc+26k4A0Mj/iIT8W2/JJ/9SaS3Bu+yCaHpVyvU3+XV3Xjov2AghyzKxwZIptVrpZB3S3bcpZBVTWkDKLLU0abpuhjkl5LIu+EgjYZyVL7RjbE8ukjmT3q/Hldwuvn+jgLy9FbY14tkujg6kwpBX43q7NpSaIa6nW2tcupmP8xSse0z/UOuXcP1GLfoHZgSHfAkmEit1gbt51k4RXhvDjss2KpQsIK8pXuZOdSJTVUGl6tICl7U29/WTOdOprsEt88v/KxjBinZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGMmeNTfuUssPiy8f126PDQRZxn98HerjykqpUm5ajI=;
 b=QvIQoNwvoWx1P+0oAAEn0uVSWA+YuffMc5EGQIzDBjmcwleLjMfNhIAuu4mgCTHa7ErAA9SRtbR9QfGpawk9qkKQMTeBAgqpQtge1GKzsGtilmRN36AqSqzfWL0NMbha+FZi5gv/aKxHjQTQf+/eFHPRqj7xToVYaQJKaY1gFJA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Mon, 31 Aug
 2020 21:09:50 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 21:09:50 +0000
Subject: Re: [PATCH v3 7/8] drm/amdgpu: Disable DPC for XGMI for now.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598889049-28321-8-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <7518f239-e1bf-f46d-fe88-8920c60ca25d@amd.com>
Date: Mon, 31 Aug 2020 17:09:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
In-Reply-To: <1598889049-28321-8-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 21:09:49 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bca18b7e-8cc3-4c0e-648d-08d84df232ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3179954D2A4041504406745999510@DM6PR12MB3179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /e65yMyrZ7onIJqxNk+x4uWDqtXZkgszq73sx5qxlseR1q5Z6g4jMgrJTJLMkMRC665vI4Efc33jfxNYtBEwZ1qbNLLtlIxbfBMkb3PafE3dz79Jal+vkbb1taH87eOrLSKKGkYEP8Ds3ArNEPxZeG6s1A0bIWlAMjfHuaX/Q5Rh3VS3P9xXqp72t80v+JniI6ZblAxw2/M4HFAAcNyFp0GPvq2aTz98rHz4nb/63XjnjcfH96RXIBrhFPmyKhxdazJBbSNJmSsWaRF/gPWnNgL/jWYrPqB57t00GO3AL4pq0n46k2A++6CYgPKU76Ej0qXlfpHbyo6h/nZdbVE6rPA8wMBEfKADLnE/0Fmd90kw8Yj8/xUZ33F/AzHji3Up
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(316002)(16576012)(4326008)(186003)(66556008)(478600001)(86362001)(44832011)(6486002)(66946007)(66476007)(31696002)(2906002)(83380400001)(53546011)(8676002)(8936002)(5660300002)(26005)(52116002)(956004)(36756003)(2616005)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SqX53hNB632Y67NvHgsGok/RZWntymvFMEvgr+jVcyJ+y1DwFl4W3SiHniWqYqZeQq2lb0mPaqMOHvs+MDFmiFAY0WpIy+QSFdCxq9qZWe8/EatG8fWdLLBfRRriUdLgjqebyfgBq388KMAsd5Ngyks9zNmiUMfkSmA2qLHX+FL1JrzOlDuPsmL6IPlqL6v2RbfRrdxmWDTxAVKm5mLVG8y+6oztCC6Am7q2Dhaq1MLbS0E6uAFjdCtMksM1V9+G2Bx/HrkdVjENivq3budzfB6bbEuaq+5EwlH7TTyHhAjifJu6QGZFlk5eDGfMz9NbhO6PEcx4M8X/ZaTAvP6Q+qqb2MM5bVXM0X9DyQnVL/K8SbV1J8yhUlwkNJDSFpmnvIGvNaOgsyrH01mB81suBjU8EjKk37ng1gHnXipRIlh5jtmeVwUrgq19TC7d3W1F7H1LyYL9MYuxEqrsiQccWtI5Pf0htMRpwsduAOLhv6LDHzfu7cXYG+0/gDkEITddaG+YCGNsiYwQp9458g7Iwb+UNLyfIs5bul6QkEIR1mOAnsSf/5ssLTOIWImAHOVanGfnGFeikqMYte3AcF64ooOMb+KeqxB09PtMBqXdTU5xZBVDOkBjUat8rR2X4BwkCi6klkiLAejR7+4z+k+gHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca18b7e-8cc3-4c0e-648d-08d84df232ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 21:09:50.5295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRbD4bpcTL36x8mCWokqBEGmFHbTZUGaasJ0deSD47q+BvUklNZaNCrm8lpp0M/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-31 11:50 a.m., Andrey Grodzovsky wrote:
> XGMI support is more complicated then single device support as

Typo: "then" --> "than".

> questions of synchronization between the device recovering from
> PCI error and other members of the hive is required.

Typo: "is" --> "are", as the subject of this long sentence changes
from "XGMI support" to "questions", which is plural: "questions ... _are_ required."

Regards,
Luben

> Leaving this for next round.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b31868a..fe720c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4781,6 +4781,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>  
>  	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
>  
> +	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> +		DRM_WARN("No support for XGMI hive yet...");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
>  	switch (state) {
>  	case pci_channel_io_normal:
>  		return PCI_ERS_RESULT_CAN_RECOVER;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
