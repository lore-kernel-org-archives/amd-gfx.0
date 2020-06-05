Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20B1C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722C020663
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HFOxX92D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722C020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251616E901;
	Fri,  5 Jun 2020 14:10:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1377C6E901
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 14:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgoCTvfL0ejTRT292KUpO0d2crQxc6Dt2e0/rSJMd2i/9OFlk7zpAQbTfk+1ViwLgCArMrGuZLQvpq+FlrCWy6cXV6EmMz7qBmUXqtTOYdELFAWBIMQw/4uaL/DPID7qttf81gUitK7dWjV5wW8uMP0WnBS9CNiSDL/JoMWuJHwZpx52rGR1+r3/zCS2wTgQmeexvqHD/aknWt+co+vMq8vnIpHLaS6YKvJvZjSwCax2YVRbIkul4qgXMAkN2kKlgiMb1kr9DkGfb5Dnh6zN995OrjW1Nt6oy9vjH5/8FzjNQJ+7Go72PGcwI6HHd7XrmfKmwV1o5G0duj+pPVr38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlyxuTUIHFIApUFBHYAzHKY6ZvEgiJt46PLN4GzUlvA=;
 b=aL03+7djHNlw+zup7dli9k7EO+IclSB3NiUXGV2keQnZtjuj/U3treECDjDSVSwA/RV6HWPMjKFbaimp6zwqus0Rie+1XZA/gVbdvUrDV+q0D6oOnvqXX9O91MZ4xjFAFHUuFWcpmadD1VsP0ZpmH/7COOpYtYAlgRAK9U8yrCrAmMb6HaI9ANf5YqcF0xINxC84nFhJ+gJZQjHhO9oGO7etKLvMf3F0vn3H4S58Cu1PFSfvhrOBJmhMrpBt42aXalduupe0ZsFbx16cyECB0hZJrQj4BCzgjHxBryj66RcgX4FNHJCNZdI63xbCXqJ/z3nFn/EgIXr3fkv3N20MYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlyxuTUIHFIApUFBHYAzHKY6ZvEgiJt46PLN4GzUlvA=;
 b=HFOxX92DH11xCUSoB7XW4QBm6832W49NOz5PalwBxJuO/xAbRQ5QfDg9BVhws4gZBn7Qq+hll/xO6x7LkyG027J8LB5YDDaY8yN+EX6OdWFCxqtxhu+5Tid9lUCu/ZEPkPwA9oxEdm2FzXuQyi6S4spuCPu17AF9waM7IS2Cx7E=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3227.namprd12.prod.outlook.com (2603:10b6:5:18d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Fri, 5 Jun 2020 14:10:04 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 14:10:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic
Thread-Topic: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic
Thread-Index: AQHWOznaZ9JcTgW3Wk6nJGdozn5XzKjKDg3AgAAAp5A=
Date: Fri, 5 Jun 2020 14:10:03 +0000
Message-ID: <DM6PR12MB40752665F199B53B99DE432CFC860@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200605130412.202089-1-likun.gao@amd.com>
 <DM6PR12MB4075B8807E76FF2925063F35FC860@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075B8807E76FF2925063F35FC860@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-05T14:04:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4b76a02e-c23a-4b0a-905c-00002e517422;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-05T14:10:01Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: aa7dedea-bc20-452c-8732-000034d43210
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ba9fe86-f6f3-474e-724e-08d8095a24c4
x-ms-traffictypediagnostic: DM6PR12MB3227:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3227499DAF3962D5A0E12034FC860@DM6PR12MB3227.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5LNjAEkGDyXxL4lAOQ/Or1T7d8DJxcJZgpiX0lOtGYIMaGMBrkeS1lulSUBrwNCmVJENIQRzLJcK4jNTaQAuD6L4/b08DS3dGX+1xoLdRZCF6IQUCtZrg9DuR21VCHB8fI1ytD9B1jXb8vbl96S5ketGi4uO1oCxt/5ucQDaNuFBMWeRhEUyBBVHaC/6GFsgTB1/zR2QcQ0jiFUWNNf3rBCB2aAwU5uA7HtmsxK+pZiHbp7JmJrfk7LcI2OsuOR1J/UrnUIqD1mxx6tdqxD+ATeJ2R8d0+BGsEooGAgzVrJvKxHloUsImh9hhbKntflHJxd3hAyo5K6HFOuSviMx30krRCH2ACFX1tXv/Hr6UtM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(66556008)(53546011)(6506007)(52536014)(7696005)(83380400001)(110136005)(26005)(9686003)(316002)(76116006)(186003)(55016002)(5660300002)(478600001)(45080400002)(66946007)(4326008)(64756008)(66446008)(86362001)(966005)(71200400001)(66476007)(33656002)(2940100002)(8676002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vgdkoxZcvYSxoA5FbwU7noD8pe7wAr9OvVjxYAu024vIH8csGiITHXtfYr5zqznQuhxfz7E5BBw1qAuusx12TyEii3Hdtr7mrJzqrUUSYbLXL0xFf5ZdZowTIDoMv1lFQMeWtBbqaj5rz0BWtzXDvi906ll/r8wt5EQo56XX5LxGwgiYz+ER5myaxWH2uPbh06ZRQJbsQaFGlKG49+LxMLZO3TJ1+eXZY61OUpOzhigERPad4UCGMhQHVEvQMSILF/rLbHlYJUwRH+4U3KItueIEv++vxwj6o9ABfUi2p7yY1yo/ou3kpxccRPkdK1WumLDdMZFBp1FQ21VDCg8FxSuQKh9W2Ktx8pXm+8PmaIzQlEuLcMsCiUItLMYhzmUt4JlDoibeNLAS62uL9ilzR/QVi4fov7NbFWLZaXq9M2cn03/Oqr6yekvYEUwQ+0sPIMCDyj6d9Lt/Tm3jM6v5YKksJvQyl7AHcIsc70mMMEk7sOUWQosmV90uV7pNBH2/
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba9fe86-f6f3-474e-724e-08d8095a24c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 14:10:04.0022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyUHI9YTrEdnds8uF5pbtfhUXV5x/IUftu/sNileUurZAk26hAO1r594nWCgPpGrATppl7I2q2NwLtMrzQOBFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Wait, I see the risk. the amdgpu_ttm_init is general one even the prior Vega10 ASIC will invoke it, and they don't have atomfirmware support.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Friday, June 5, 2020 22:05
To: Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic

[AMD Public Use]

Does it mean there is legacy VBIOS that even doesn't have firmwareinfo table and introduce crash?

I think we expect the atomfirmware interface return 0 for ASICs prior to Sienna Cichlid

Regards,
Hawking

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Friday, June 5, 2020 21:04
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic

From: Likun Gao <Likun.Gao@amd.com>

Skip for reserved fb size query for the ASIC older than navi10, as those asic do not need for TMR region reserve and may get an invalid value.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Idbc57805b8070f27ba6c3cf22f1892d6dab92f06
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index a9adccfda4c0..e2a64ae7bcaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -603,6 +603,9 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 	u8 frev, crev;
 	int fw_reserved_fb_size;
 
+	if (adev->asic_type < CHIP_NAVI10)
+		return 0;
+
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 			firmwareinfo);
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C3e694422d2454046603e08d809596b07%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637269626942920124&amp;sdata=n7NDuLsmSx66FSf8OXd4rpq%2FLXNmTEAo%2BiWAuqSRbC0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
