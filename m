Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F6C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 08:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C663061477
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 08:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C663061477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502DA6E2D8;
	Mon, 29 Mar 2021 08:14:42 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690084.outbound.protection.outlook.com [40.107.69.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCBF6E2D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 08:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVFun/fnIhciE4vI7gtCvsYD8dkXRnBDZ2KhFEMHfwxN/xG9ak5+1ixSXc3n6HiDBmcm85h+4kz6FlZQo99d4ElVP1qiMhZHNYLrtqipaDlpHFVMNxHa4B00ZDQsKQvQnzE1DzumCp4pbC5KlxBEaHba5Jg7lrbndElds1DgfyG1PFOR0cR3r38zNJkfijVvHug5Mofg2agGphJdDrlJm7WlaUOkwP5gh2+kqDdUjhaawcF3FdO+8mp3PNfKP+6lnXlaswqwA52PG70AGXLY5L4rrBp26+WmRw28TzoBsZJceb95fAUvKd8Hqgi35wjNUl2DEo/B3BYVvoHXv8/7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tol2juFfRNWDB8qzfD+TpmsKHL9FglUelkpePhEraUI=;
 b=jVdZB4EXxE2CggU4GK0ATFJm0tIieJ1Xdh8WrwA+zoOxiKPEmoUSAKPOoxx7ySiuJEOoWOT3kx1fL9ZzImEh/VhRxBCo4TLrYsivR4D1ouPHqAV4B6DEn0qbrcfmTj+ZR0ye0DdPnh13hSMwvZ1/QT169mr3w1d+GnmKx1+M7hvOhpJdZV+04v0wEHWmuW0sVii4jmhnPtWF9ryHcx9q4UhIc6H+RQAN2I80Oef5TXF0dS1gU6B+78O6e0QPVg3DFc094aQumx/vPukZCsiXvfYXhVUkrO3nD+egw4swXH1KzABRoSzsNUwFse1iO+lvBGqmBC7pbFAzRW2ocXStcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tol2juFfRNWDB8qzfD+TpmsKHL9FglUelkpePhEraUI=;
 b=rZ7DU3nxuI1Fp5/VPx464kQ88Bq4XPZhAx+7dlJpKmPIwJ8LcWryJeJ84vdCMmMyMOIpCLYxT3IWrKD1effGH0S3vDGxqO8RamEXWokMeJ9UNOzbDG7CfPFYMa50ULFYWlzgXMYMg7+SFYcnaHbhEU3m807uUZ2vqZCHD2dil5c=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB2386.namprd12.prod.outlook.com (2603:10b6:207:47::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 08:14:39 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 08:14:39 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXJHAe1Q+bq/nbQUqavv34qhE6AKqanU3A
Date: Mon, 29 Mar 2021 08:14:38 +0000
Message-ID: <MN2PR12MB4549105A7E279AE92C812966977E9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
 <20210329074935.10822-3-Emily.Deng@amd.com>
In-Reply-To: <20210329074935.10822-3-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T08:14:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=21c52da5-cc0c-44ca-8dfe-929a0973ffcd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.197.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1520cfd3-80ec-49a2-fe58-08d8f28ab2b7
x-ms-traffictypediagnostic: BL0PR12MB2386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2386AE1160B683B913215302977E9@BL0PR12MB2386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81FQCiOArubf4Sc1uAjdKBpNvtJapHw0VvVd22WbXhJkcp8SA3UV2Xbg+OfudQuuIvZ81pcqggei6NTX9K9gWauKunr0Gn71h+o2835JK7RkoVU2ZTkL8+NSJGo/nIGEf+eboDRBpfXz90aukesfL7doVKnIiTj/5gHbcVhBrwUAJIPwy+uOnoHWPZ8kyBUk1NqgZmu7nWz8HqQA0lpEaZtXn3woJwXMQYCocXgI2gu007e27y8/hBsbYgzLfNb/urWkVVsKWaPtXNct/fHkeHmnaMJcX9ZWFtmmtujlxG0YfVIWT2hrWa73NTxQ7SHrFG513Bbbe2KzCXo0q4gMYaS7hmuqZhIWhfa+jA5waP5LaS1Db6rlyF2Z49JexIEhbhx0z0VYisyCGZp1gZNdcj2wR3pjojXHkZDsf6Bj1NZ9S/HrkOAhue1Gr3OpwkU55MoFVg12GLzZR+QLCmp8lgvepLKnHl/lz2XQhZyaxo1NAgv3SlcZ7gsKaIamT+ZafdJLoLb91uwDwY355KNPVvAqk0tAeEuAbSycn/MdV5TDIYhyjuhLjrKMujQzqsC8QRsk2ijJHNuKx8Xvmec7zxza8j4fQ2MKohzIsTCNpR3JZIqZBumej/90MsD47uFKG5u+y8GPdcI90j6A6vMLhj9hRLNEqUY1HrIgPx18XOHtl5o4RQJoAdGHqhUYPOUvIR4yfY0gAficZxaFgbOCrg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(8676002)(66446008)(66556008)(55016002)(2906002)(66476007)(38100700001)(5660300002)(64756008)(55236004)(86362001)(66946007)(7696005)(110136005)(9686003)(8936002)(316002)(76116006)(966005)(71200400001)(6506007)(83380400001)(26005)(52536014)(33656002)(186003)(478600001)(45080400002)(53546011)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CcmlXu5phsDgeY9pgD+N38mNWI0jJ0KoE+5v7p5fKXZBU/6eJvP5nnKSFZjT?=
 =?us-ascii?Q?zdtajoP9TeDeEocmjo1UCym5oxKOFLLYnnTKKyIMWyRcZ+2V2KTg1sHU1Uqf?=
 =?us-ascii?Q?IaJ6Hwox3w/uMGsNskaID6JxRenVQkXduKCe177SLDdn72BYalLQRF//SRbP?=
 =?us-ascii?Q?GBvic73JJgNz8tkMbLCpwh8YsMzh/IgofSf9PML/qQM0Bck96y+oSfLEm6pK?=
 =?us-ascii?Q?SCf/1r0gJiIvr5tWGMk5xAA/MeKONej4jWuH4S7FTzA+4YWmtdXehN0+qRJz?=
 =?us-ascii?Q?Es+k3w1wMXeRHO++Z/wwXjpshxGt2cIh5weca161lLNI9it2ih187XCM7+UO?=
 =?us-ascii?Q?7qyCrdseH8yN0mC4+ecBImCLK/d9+D8y/62TqnUsJHhInfOTKNTD7I1ssLPd?=
 =?us-ascii?Q?HmZ02BtBsZ33zIwtjRYl7YD4QDijeh9Y9VkTOYlOCD0OCMKW3dt0oqXaIQSh?=
 =?us-ascii?Q?LQWjoILHedhLUyut5GrCnsl4FXIyA3p5I/tCcg+HV4A6ZrKV0GwajkwQ6cfR?=
 =?us-ascii?Q?TwZupFgKVHn8gbAGHVRQzSVDbCeS2St8WZfexTcGZv+SXB8iBQLfKeSx7TJf?=
 =?us-ascii?Q?/7bHgtQuGUw4MuiDHGgDRRYymyKOf6Icebd1OwU8KWB57D5eQ+Ll5TKhMeaq?=
 =?us-ascii?Q?j2K6Q5yGNvX4DBCvOIiEPVnCS8xf6isSZo16VnvE8sr1QdfQx/8FtL3zCF/h?=
 =?us-ascii?Q?AwsxFzD+/YiSWw7FESbQuAuMMNfVLsL7ooE6LfFH0dt1KN66VZ2EjlfwNrcG?=
 =?us-ascii?Q?Q4Ld1KoiMXW7Q/j19ue2r1RqZj6VQ+4dCge5Hrdvby2tm29a/xiXRcuLnDzz?=
 =?us-ascii?Q?tzeEOaFJA642RvWFWLlRb37Xzw2/Cbgxc8NFUo49JtFoYTMyAIPlLmoS26xc?=
 =?us-ascii?Q?dgf8fRMOGSh+bpSdekw5rNHNP4uYID2V35xd745udI2m6vz6zBxpkaOxWOvB?=
 =?us-ascii?Q?JCXrghQ+oSDwSrEbNmRa0fqDrweEumtcVc4Ky0ZwvfUyomNaxVEJZtdmU+Lb?=
 =?us-ascii?Q?6Rh0YfpSde8fmbGUSvCl2IE8Es292i8ERLXWodkZdUZgRk63zKVjtuKV6vDg?=
 =?us-ascii?Q?R+O/2T920J/IS83lLKrhLfmcNuJatwyfDbXrqLsKsghdpHt6HvOhh7L5ASkQ?=
 =?us-ascii?Q?yzCFHH3P2mzvcRuZ3CumuhewrmAmEF50EEgye6J+wU88SlhpVAkRNwCiSeU5?=
 =?us-ascii?Q?1B1UFKCx7eC4VXdPHRCl/peFGowflWvfECcOmbIlHkP2mVJZcD7DKn76JmaO?=
 =?us-ascii?Q?mDjeNtRDaafdd+lvtmyfTAr/e0g2ZVRySFIVaITqsHSUGaAXfW+lSO0pRqZN?=
 =?us-ascii?Q?6AMfl22wh08y92Hjw5b0FoVS?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520cfd3-80ec-49a2-fe58-08d8f28ab2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 08:14:38.9033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Au7Bm67Y7mo9if9vrU4QsocjOeBOgJcX89aJsEpS0VTgIwOLvVajkGxswxNEMdNP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2386
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Monday, March 29, 2021 1:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Restore msix after FLR

From: "Emily.Deng" <Emily.Deng@amd.com>

After FLR, the msix will be cleared, so need to re-enable it.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..f24263120f3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,18 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_restore_msix(struct amdgpu_device *adev) { #ifdef 
+PCI_IRQ_MSIX
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + 
+PCI_MSIX_FLAGS, ctrl); #endif }

< > pci_restore_msi_state() is the API to do this. 

 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)  {
 	int i, j, k;
 
+	amdgpu_restore_msix(adev);

< > This is not needed for all cases. For ex: this is called in other cases like mode1 reset where entire config space (including MSIX) is restored already. 

Thanks,
Lijo

 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cb583583b1aae4a93c03508d8f2873f50%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637526009994752107%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=E6prbMAEwqsWBIFGqrgtd4i4ucg0OBrpG07G3xTuTqU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
