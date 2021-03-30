Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01FC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F786196C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F786196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F0666E86B;
	Tue, 30 Mar 2021 08:07:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E2F6E880
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6270WdJI0MpqeuCeujUkJt/cr40FaBRtQcS1wNGzmh8290w2+xNl4BHjTUzqHaBy/OwncxdDUb2z8rzJAOaVrZ6zFKUuMiiUmn6gXj93wpX8L4evJ5tkxCqA5bYuneCdqrWcpJtQ7w1E60wpKhAvKhyf2wNlbyz6E13LkAzr5ar/HhHxMPNloU566FjhaLeWcmS7gWAIG6YaDvLLakraZ32Pq3ZpbphtSpVcXtHTLnSvQs0vbbMcbL+3cPV7vwIQwONAYzyZTgE+qdZVmh4zOdp6bOVnCi4iA1JAPGAkJrdR0pMVtNQXNZL7NhnF7BWABj9bIHqHKUmzX1b9nmD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gezGhJMNW/jrte/Uca3fuoprE1RRtN5PKsrfEn+qHVM=;
 b=Akbewb/kTl6oyGJh6qZ2tfUQlZC+fO3UkYtVWHDbBmyCa71Kr1MzUZbnVrTm6X144q2z3qBCR1fkWe6mrwEWAFRYlO9+G1SrHh2mKTSYeQ2gjr8afccn8zCJ9LDl9F2m2N5+NquiqBUIWPY+6FXXoSqW7QBNWV+O8gNkKW9ANQHDx2lS/FoJkUJ1vs6E9D+d75/fciMU4Vu1AuZ3zRXTsw709GxCfRzFefvBhmhFqR/UMDHppITA0e9cdi2wSYX5naZXOrtegTRGeAaIurOCnHnyYluJracClLri4YSHT5FRyv9QJ/TxLE4e+1ZdJKT0FMbkRVlxU/qJu/NoXL3HaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gezGhJMNW/jrte/Uca3fuoprE1RRtN5PKsrfEn+qHVM=;
 b=X3k8QKJCbJkMhLwGO9Zbw0rLSEWqIcvqoDPloytr+koWc109zico61HekioCBmlLPGDyTXvUWj0txhKgqRHh2VcUbDYs/DPYfxR5vibggKSBTKblw647n7cBt6wV/q6pxNbnGuXD6qBa9nRT+blTxwb+tAjEwjskfK76B1fXUGs=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 08:07:30 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 08:07:30 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXJR8GxPdWNjDyRk+Pe92mjJkYK6qcA2YAgAAptdA=
Date: Tue, 30 Mar 2021 08:07:29 +0000
Message-ID: <BY5PR12MB41153D1F38930F1FC9CA92E98F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-3-Emily.Deng@amd.com>
 <CY4PR12MB1287EF3AB5D60462C73CB4FFF17D9@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287EF3AB5D60462C73CB4FFF17D9@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-30T05:37:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c1c7b498-a5ec-430a-8c76-f30e3fdeb4b3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 843f3305-1433-41c5-6e07-08d8f352dd80
x-ms-traffictypediagnostic: BY5PR12MB4885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB488599B0750B2084B3AC88AB8F7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2ieL14XT160Q7A12GoDLW+QBJLq8yYJ82vVDSiUU8uDrzWtKy5xWWeccilUTPb1IWQe9JZAQrMWd8SgGHzp2uJZgDvrhtDgnvKGRvIaD8NysmkJpM5aSOVmPUqbQYAVwkd/Isu9h7Ahh6P5Mq5+PrwxavWOiTz7JjKu5zN6Vp9ErJMtKxtx1/vSiBs6oqs5yYiq4MwwAz2Ux6meo0Kw0GJdhxPCFaJqw8XD0VZH6Mb70bPj7s16+sSgCXWHOja46h7Mr0+ROKVbk4ipIBPMs08rRpKHMEqriX7NyjSuIlRLNpNqn46ITaXvgJyURwe3DgWMi7bIQ8BFrDvXXwSX04bPLGFwQCX18twPkbYFkWa4JO6JKAX08g+Bd/8nP/4bwclrC1MSDt2TX+NT4TjKXw+Tz39LGLookeT9btLf4ybCl/6i/LdcC3Ys8C5xTpPh9bYz90fqPIxaL5guHWVZajwmtr8VVJScufVCI3MMw4TWUqsVUwzt6PpdD51/Yfr2NNVvpH5dXxiaOWX7isdTbgFLVh0htOJpiup6go8JQmlJfCEsz/8XiwZ9FpKMJZY4C5j2ciT9s/RgMuZCmHVN0kPCa/YtfMJm0zoB0aHovmcCAAj1isGSo7tWf/vLhXpe06KjDmkQSK/Dl9o8wRbw725V1VjU1PK2A1DYktI0JhcaPgFd8PYOf0XpSp/S9giL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(9686003)(6506007)(55016002)(316002)(83380400001)(8936002)(478600001)(52536014)(5660300002)(186003)(7696005)(26005)(33656002)(45080400002)(86362001)(66946007)(66446008)(66556008)(66476007)(76116006)(2906002)(64756008)(38100700001)(110136005)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ruA+v73mBohtD7Wwaz8rNyPz2uDZOpdtg8j+6H5vON7FKHiu1UvA6r8ejbI8?=
 =?us-ascii?Q?E8Xrk0qzl/8MEWdDDyRPyQsszdcHVypAo3oJd+VEIA1u4TKcK12dmJ2x3YtO?=
 =?us-ascii?Q?72LvqDU8Pa/0gTU6q8FafCEwNB4PS9Jyt+c694R86nieHSEiDjhGkqdflUAZ?=
 =?us-ascii?Q?E+luzl35F24jjMm4mtvkQ7mclhXmVWWq6ouO0IvYKDxLxjlFNpG0fxVVQjbe?=
 =?us-ascii?Q?SM39U8ML7vfYpg1+turAX2LE5qGLlIu59HG0aYeLrBkQbgy3oU2MpLCFjRkr?=
 =?us-ascii?Q?5E3I/WLQRY83Om8mur6M5H9iX4k2jccnzTiwykTsRjWBU73PbfRHRmqmDrko?=
 =?us-ascii?Q?28yL7yOGlUgdUVl7L2sxAcfh4SW8QRyz60G1Fy5YzCPuNY8wrqhjN+kMBOje?=
 =?us-ascii?Q?dAun7HO+1Om6W16MZ83rOLOtxqpTeJdVp8B0A8tIdge45EjSBHzvV+lXM0KQ?=
 =?us-ascii?Q?1G7Jd9sV4MVC2vCJF2zDP6PzBlxK2L7DeGg0jrOzqXkARp4OOvTOWALT0vQh?=
 =?us-ascii?Q?mIu7v6IEJeK+uqUCtP2Uu2++OMfjz/FNz40iOBi9Kr8DKvHXQy1bhgQlOA0O?=
 =?us-ascii?Q?V3lApW9p10Fp34AvDJlZCD73s6mdhWbvqXd6oTu1rrilSbXqy8j0YWdnF2nO?=
 =?us-ascii?Q?4jDlKuYHwnq3I4MnGlM6YJXsthpL6yY1qiq4JBgZfXDetRTL5GI8MNaGjHo/?=
 =?us-ascii?Q?RVpshgSFPdR7VxU4tx7GnXmYzNT3NIW72K89pksmSAOwCqMs7kxCi+plKJ4/?=
 =?us-ascii?Q?abKX2CyDrRGM4D+xAuuS/wE0ql/NnyLxO6NKS055KlvvQj/lfxZfp0w9vPod?=
 =?us-ascii?Q?Sbbay9nPiwwo43OUVyIIQpXW3LSt3Vyn7Sgs7J/PbQabCqrzmF/VmqsMTYEi?=
 =?us-ascii?Q?sUREyWJXjhPzlNddCyPH0OktpkKIAO8gZl86s+z9piE3yhB/qmH/JVJ66z1e?=
 =?us-ascii?Q?p2VogASr3mGRAARNQz17KwJ3cJ4ZjAHDGN+W6ukO1t0ZlLamYDegC8XCQknG?=
 =?us-ascii?Q?JVvz0X36YYoWYTEWypKIF61Xd8MLmRhezBjIJrBSjp/AT+60iHffk6YLAQ8N?=
 =?us-ascii?Q?IfW+Q1CE0NrOxYSYevdr+hrtb5BBx9jbz1qlVOI3D+FMMUsVJb9fJcTiK5yy?=
 =?us-ascii?Q?sL6agwp9/x5iUMEmlrxTnZ9yG+wJ0iZX79iQ7/rW9wxUjfUfly6l76RPtNnJ?=
 =?us-ascii?Q?yvuUKOU50gTMRWVrXY20pVw+g6ydlEZLAuOkexH3AGq5GetUzKa2vIPX1loj?=
 =?us-ascii?Q?36cDZspOVUjPHR99miDaKz8XPZ8V0+MyJn2IltL7j1NJjhwCF+QYxxt6JLKc?=
 =?us-ascii?Q?xJxPJ9ge3TO62IBLK7XdXF4R?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843f3305-1433-41c5-6e07-08d8f352dd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 08:07:30.0082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH5WFWb/JNl5/o2CoNqAZnXC39vr0kv2YKOIFrFj88/ugn+WFTyTEQcQgeLdLVZh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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

Hi Guchun,
    Ok, will make it to static function.

>-----Original Message-----
>From: Chen, Guchun <Guchun.Chen@amd.com>
>Sent: Tuesday, March 30, 2021 1:38 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
>
>[AMD Public Use]
>
>amdgpu_irq_restore_msix should be one static function?
>
>Regards,
>Guchun
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>Deng
>Sent: Tuesday, March 30, 2021 12:42 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
>
>From: "Emily.Deng" <Emily.Deng@amd.com>
>
>After FLR, the msix will be cleared, so need to re-enable it.
>
>v2:
>Change name with amdgpu_irq prefix, remove #ifdef.
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>index 03412543427a..8936589bd7f9 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>*adev)
> 	return true;
> }
>
>+void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>+	u16 ctrl;
>+
>+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, &ctrl);
>+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, ctrl);
>+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
>+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>+PCI_MSIX_FLAGS, ctrl); }
>+
> /**
>  * amdgpu_irq_init - initialize interrupt handling
>  *
>@@ -558,6 +569,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>amdgpu_device *adev)  {
> 	int i, j, k;
>
>+	amdgpu_irq_restore_msix(adev);
> 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> 		if (!adev->irq.client[i].sources)
> 			continue;
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
>eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6aff296c96104aef
>176208d8f3362acf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37526761267513989%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=B
>G4P%2FbJmn8PiLR%2BxTys8cVWK6924LWftjTXjKqrgnkg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
