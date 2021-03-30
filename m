Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34882C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 05:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95FE6192F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 05:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95FE6192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508866E4BA;
	Tue, 30 Mar 2021 05:37:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9836E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 05:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IomVSc5yWDAEtJswb5vHQWDMxdQ5z3zit7qF6OviQdCNHtTj13tpnt/+MqQBAqAnrgF9Y2Ws2RbJYpmsc7hE2JEjiY5bwi7P9Zk+GhwmAYxZ9jhN+ljaJM2MJBw7SSuZb55NomcfKmMheGjJwJDbBLRM/Ghwz6vVG8Mj5ag4RawnkLvN+f2BKMnXvdFQqhJ3+xiPEBnGnWYkq8UVHuGxINbWp1H8tt6QGAZ7HD7Yq1b/jfUpIuIdemDavQAKlaQvMPmcwDYcaWUeIJE8yAdoDIrkN+oXC2z/3q+1TKeDCRQyCfpSh2vHy1x0ABB8yTND/LP7xRHLThrlCS+f8tSTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r2cIqYPg1uiLn7KI88qLh5nWjab7cgBphAlEk4E4tU=;
 b=oUKvlzPWL07e+jw0tiSd1EwO/c1RLOVxNNh+4/KWtrgRwnY809nxa43Si6pvCcMcJC1iakXeWydrb8ksZcQoZYAF12dAZFKGoB0a3ajx/W0s8mqF/lK1WkqRBmVio5YlrLFc6J1zQfARzkSQn5mJYXpxMfWOO6CbX6/2KFT07REASMIrU3oBfc8CaqVD+0r010JwMS9T3e077C7ZUwn/WvZYk7kEo/cRjlcdMNWMEWYo90ObpL0KyMeO0ug/hRnoIuk4CFOq+Gte6VhYgyb/BEtyAklWAtFlqYvla4EJ2w2xpTTqMPtAr3Jtntf1ZEvzx879NI8czTB8H657IGpH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r2cIqYPg1uiLn7KI88qLh5nWjab7cgBphAlEk4E4tU=;
 b=nepdC4IWmo3xXEa87vAMd806fH8tFlzwMnEknQm3/D8+/ZIcgvu/20q5uUw5NapV8rVE/4i6vollllEpg3Pw8PGaXO6rPzPeyo9aefr4GiEkutDapP5WmCJvXXCqFqhgqMAJpSIU8dtZwbKrPZPfivEdpc/+tOoehiuAq/ncEdg=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1880.namprd12.prod.outlook.com (2603:10b6:903:126::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 05:37:50 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Tue, 30 Mar 2021
 05:37:50 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXJR8JCJJkfIteck2quYPB2Sl3J6qcAqxQ
Date: Tue, 30 Mar 2021 05:37:50 +0000
Message-ID: <CY4PR12MB1287EF3AB5D60462C73CB4FFF17D9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-3-Emily.Deng@amd.com>
In-Reply-To: <20210330044147.57802-3-Emily.Deng@amd.com>
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
x-ms-office365-filtering-correlation-id: 81515dec-3e48-4f5d-39f1-08d8f33df4fd
x-ms-traffictypediagnostic: CY4PR12MB1880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1880173BFCEFF6E8D7E60FE3F17D9@CY4PR12MB1880.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MD3AWxMGYLQKMvUfgjibNaqIK6e5zH6on5DE7ihy5P4sPYZ+3ptJec7lfp4naBiAMApSExfkjRNEhOSgm9xln+mDdw/iCGxOz9AAhIBSTlEvwaa8zHDlMw28zVRLFOx6msG3jVf13MEvlSMvrQQBookgL1jkyLY2P4CH4qX76/UJk6sMmGM2XyJQmfkLUm19w00QhVg+rTjkYEznd9gLEnl6QSfOL7AXYcgl9X1qdnIhNpDPzT4AXzSwheLBU/JRHEyZdKn4gj9St0QcDMJJwIr7eVTJryzY5bki1ogqtg9j4vnqc7ImHmJ64Z3g0b+TW8jxEfrg59F5nc+q/CNgtQmVlpubMRosZwSR3QFvYMHqStV3Hemr6eGNte4n28Ge/ELD5AOKPMBFZMpCqY4UuPxkKQEC2+tqrdn6+CwM2qN9J8/o07MBpraO10euadhofs/OXP6gKCbG6Nyu7A0CHlDokGQj5EPp0NSOTHV20IMY+QCZt+xjUg6HjZq3/CeVytKVcGnwmO5T8niZnLDdSMYzNjtFt+6OS6f0wZ/hu/OonuTtNPeOaNJgEdsEu+CS0DYT6f4awQo6lAxSZYAh+u9pyIEKtghU0fwy7hOs7YN7ML7n7pQsbM7T8yLeMGRqLHO9w5xNBC0LIXiS5rpDOT1GVYC1jYrKdTcMHOZTl0mR8/qiDb6kIjFwYb1j/1tH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(5660300002)(64756008)(26005)(86362001)(6506007)(186003)(110136005)(2906002)(66446008)(66556008)(33656002)(52536014)(55016002)(4326008)(7696005)(53546011)(9686003)(45080400002)(83380400001)(966005)(38100700001)(8676002)(316002)(66476007)(66946007)(71200400001)(478600001)(8936002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2WEHrfo0mEd+vH50Gy1gToQUXzN7ZWOSnDNUic9aOFW0TngEyOizlNsis7xc?=
 =?us-ascii?Q?gWr8BKZzyxrl5pzZzpz7xGrTqGfpy8HS6vmyKCASbk/Z+JR2sA9ycKuILAzu?=
 =?us-ascii?Q?e0EcMZDZzDLkuaNn5djLt7/waHlleU/Il2fmG/e6NUJoNZ4RG5shOMVYlOKO?=
 =?us-ascii?Q?FF3mVkxNSdPnxtpxXIDg/2ERN+Q5GOgahzIpkH7XDiueiDXTmILf0Yf0LZ4c?=
 =?us-ascii?Q?SHaH2o9Rhyqml3B8QKz0Zn0wc0WQ0awgIodRo/a/yCaeqEK3B9qKcOkMXqBi?=
 =?us-ascii?Q?rhydLI7EzND5uPZ/oFA1OxY1uh0p42PXxO9i/JiGI3/pFXkjJ1f1HDxFbsnY?=
 =?us-ascii?Q?jWpYZjofdWEx7YCEYL1m5pHsf87jaeqkUD15PqBUoh7W+R/B5SBFQz92Vf4+?=
 =?us-ascii?Q?qAPe+OhSGyV6cEZ7CNyUXFo6Pgc0WJJknhLj8wQ5aNZSZYow88/rr0UENz47?=
 =?us-ascii?Q?bnYoMwPnvPjlkoJe1DLEBju/23MqF28SrUacu2avIeLZaze9Yj3ujjLLkpal?=
 =?us-ascii?Q?eebOrnT+b1g1AhvLp4x2dO6fpb6x90e23yS+wori5C9VKb2IPrxHPpJQe05h?=
 =?us-ascii?Q?CC9/MBYyM7HGD1rhAcy+N0YLgCh5KHYMeXil83G6LhQzDnO1dl9iI04Acyrl?=
 =?us-ascii?Q?/M142uy66gjoPvKUQKBHl9IHQRbWWtBPI++Wh8tJolu2E7KJLYfZrFpMDVkx?=
 =?us-ascii?Q?JH4IC69tdw0nu7nvSrfIM0BTsKq1RPeE6bFgveygpDwyK17Gwd4RcYUf2J01?=
 =?us-ascii?Q?RZ/0+q8W4n2lVjV85mh3fNqyaxhQiMNoMBnqhFhrnM/GqewFSZh904yDE7EF?=
 =?us-ascii?Q?8xbEOlkGj7ShG3rLm5/L33FyvgDdXQxNTA7l589furV/+5uqt4k+CeJAclF+?=
 =?us-ascii?Q?k+UMWuUX5qbx94uVd41WW6YMlKG0ywIf1hOUOeEVcfXFbAnq6QJ7BijUWp05?=
 =?us-ascii?Q?54gdxisjyj8vo940xSsu4PEHkb+dpqUQlQZQQz0umuPjduwHjHXWZWJ3mmpg?=
 =?us-ascii?Q?9iEn+DqRwYEkD3Emy3y/YzJ4G4RggSE2qp/enMZtWF61AghZgDADsks/m3WU?=
 =?us-ascii?Q?v54EC2gOwbUTid2Ic4cE469LdYrgj265zvzL5V0qf4bWmR8XR+ukUeXCvHHm?=
 =?us-ascii?Q?38Q+vui4NYB4BysgKa1CVzqT52mMPVLdWvFl/wJukLShNW/dXSBZLpQZmJEH?=
 =?us-ascii?Q?EKunkrpafadP2yL2SLmSvbkjClutfnhCHvKs0ONJkxsmAKHuX4FXeL1NWghG?=
 =?us-ascii?Q?JMni+pO5IGX1SidXv40PEVXY6W6445zJayakckXsPXPJpnJ1OFkPajgvTT7+?=
 =?us-ascii?Q?NiJav2h07BY5kaqclwz1nnwE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81515dec-3e48-4f5d-39f1-08d8f33df4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 05:37:50.0566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/gAN1cNgkqufCdiKcjEnXZcAM82LI0qEyz8FGSVqiAe24GO1Kk1RH99XLjqDC/u/hvQCihxeIXOxiJh0pJ/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1880
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

amdgpu_irq_restore_msix should be one static function?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Tuesday, March 30, 2021 12:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Restore msix after FLR

From: "Emily.Deng" <Emily.Deng@amd.com>

After FLR, the msix will be cleared, so need to re-enable it.

v2:
Change name with amdgpu_irq prefix, remove #ifdef.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..8936589bd7f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + 
+PCI_MSIX_FLAGS, ctrl); }
+
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +569,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)  {
 	int i, j, k;
 
+	amdgpu_irq_restore_msix(adev);
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6aff296c96104aef176208d8f3362acf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637526761267513989%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BG4P%2FbJmn8PiLR%2BxTys8cVWK6924LWftjTXjKqrgnkg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
