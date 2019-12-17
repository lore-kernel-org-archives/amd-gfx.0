Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95118C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66904206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rA586LTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66904206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E986E040;
	Tue, 17 Dec 2019 10:31:35 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5E406E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 10:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H84YF8+Mxw1XakwwxCQcCiltmoG8V86tYFOP6SKlHwZjz+KheJiymdlVVWOC9VlQWEK+PVcy14OXZbovZccg3RcARebDB7ksFcc0EnR5IhQSXXkjEn7tdN3l7ka1Ag332+Hx+HtL7HvPMox9cIzljqdUkqQ6NbxBJ+JQ7GeRpIz5sjqNPe5HbRMzC4e0T6kfq5dFfRXHk7+T0i00df9eDpVxEKOW+7/3VIVYrwwo2AFQeMJ5XKPdL9C8xE6GL1RbiqBtMqFrbZYNVZRWfPbRcFufcFR6R4IO5QH2YWRKPxCzUZCH1UNET4y2Y0eBn967MlsmFTovdokOhXGJYMyFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUfZpvz+CLXUuWeFyQ1GmYRjXpEZoY/7H9F7GvT1nYs=;
 b=mdqTucd837SspJM38v5hAjqTjTSsbdGB6zvnU9ZF6uoJVJCs3G1tyIDPZe81Vu6wcFj6/4ciXQH07qHbbRcVybkdfdqiUZ0gIJilK+auUnsL552IE+1i0/+jiFvIyeHkMjAowINdjOZ2U4wiuhWVxmqxg2In1tv2RCf1fIvwLUMeknnPFwCjh4XSGnjAk4sgaedTrdiUE3txJBcAdEHGEYDCYN/wywWVrOzykUevJtpWiWdjdZPPbsd3xfXk9pmIwkvFg8qfax5p3C9/EAhhSlgWO+ZONWqcWdaFPXnTCkmJ76QTwb8w4n21nUE4NeSZpYsRWeHxDHk6udUatEyufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUfZpvz+CLXUuWeFyQ1GmYRjXpEZoY/7H9F7GvT1nYs=;
 b=rA586LTOO9bSdwwHGqB9A6Lm0b5avjq3N88kai4+QgR/N2od8RZ9I10TS5qer/HQOndNS28kWE+MYXEqq6vF4d9W33hMQZXtYzN00O+Iw+tOgIq1kHjCeNyUOyIpA9cO5Nrnybxdm6PSVyNTfUoHJmjuXzizKQnyU2Fp2iqgHJk=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3631.namprd12.prod.outlook.com (20.178.240.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 10:31:32 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd%4]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 10:31:32 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix double gpu_recovery for NV of SRIOV
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix double gpu_recovery for NV of SRIOV
Thread-Index: AQHVtMOa4L/9WwnBzUOydMW/BP/Ebqe+IJyw
Date: Tue, 17 Dec 2019 10:31:31 +0000
Message-ID: <MN2PR12MB29750153ED59E870B4A5A3568F500@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-17T10:31:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cd8daf0d-d949-4361-b771-00000f6ca3ef;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-17T10:31:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ba124bb6-1343-4ca3-9811-0000be8a7db2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b19f2ad8-729c-4601-9e81-08d782dc48cb
x-ms-traffictypediagnostic: MN2PR12MB3631:|MN2PR12MB3631:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3631AD9F4491D7A5C7ED5DA78F500@MN2PR12MB3631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(13464003)(189003)(199004)(2906002)(66556008)(316002)(5660300002)(66446008)(64756008)(81166006)(8676002)(66476007)(81156014)(86362001)(110136005)(45080400002)(52536014)(55016002)(9686003)(7696005)(8936002)(76116006)(33656002)(6506007)(66946007)(71200400001)(186003)(478600001)(4326008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3631;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AocuJkGhWS2vmD9/jZtf9culxbVdg0b00vkAUW8BUG/W2NiOB3I1N3u4kKjHkKpmts9ckRzCIxIehzFMiMwlUfOxbWz4ik2UoboLLio7x5Gnp4FNWvaLdfq4qeMYsMclGjy3r5qxyWC/yhDeG+DskFsTt1spRo2IbHBuw1zK86MSWLPyqe8AtaIibWqMEFbVxaFGGf1vKK5q18IWc5pRycFOxNDZ7p/NJpAZVemsS29L8UzVhSGz9C98pjV7jjtfM28/Ivg62bPBSUO2uEAmQPhEOKsKGHbpYY3ytlrhUwiw2m7ZGbIV45LWqgBSjoN+XaNjQz97XCDiwHdFV2MVmIjo5NDdyj/fg12fANVgg124SuavtFP7hyx69RfVk2vEd/SNOYG3jBfw7Kkm1Ezkiljy4fQKBPldJNPpZwRaROMX50kiwlazJ71ueO4f8Mq3QrPWpeIOuyckB8NqmyJbiY1EMmuae06pyrTU44zIHU3UU1iTfmMrVu210WC60H2u+po3wWsFSIYBgOJfp/IqK9miloqtmV3im7BvIJNy9jk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19f2ad8-729c-4601-9e81-08d782dc48cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 10:31:31.9485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNL65B8Sg30A0erPw0TvPJyhpdE5d00kV60I3NKzZm/QSp6vUVcGZ5YFpywiCPWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
>Sent: Tuesday, December 17, 2019 6:20 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Liu, Monk <Monk.Liu@amd.com>
>Subject: [PATCH 1/2] drm/amdgpu: fix double gpu_recovery for NV of SRIOV
>
>issues:
>gpu_recover() is re-entered by the mailbox interrupt handler mxgpu_nv.c
>
>fix:
>we need to bypass the gpu_recover() invoke in mailbox interrupt as long as the
>timeout is not infinite (thus the TDR will be triggered automatically after time
>out, no need to invoke
>gpu_recover() through mailbox interrupt.
>
>Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>index 0d8767e..1c3a7d4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>@@ -269,7 +269,11 @@ static void xgpu_nv_mailbox_flr_work(struct
>work_struct *work)
> 	}
>
> 	/* Trigger recovery for world switch failure if no TDR */
>-	if (amdgpu_device_should_recover_gpu(adev))
>+	if (amdgpu_device_should_recover_gpu(adev)
>+		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>+		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>+		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>+		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
> 		amdgpu_device_gpu_recover(adev, NULL);  }
>
>--
>2.7.4
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C029ef88677e744f2ad
>8f08d782dab68c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7121748276776005&amp;sdata=IiRwMTw6DQW8sh8Y7SkZ2PehohwnH6gSqkt
>t64a73UU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
