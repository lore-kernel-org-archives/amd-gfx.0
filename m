Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE323C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 05:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3380E20658
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 05:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RNVlX7kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3380E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908A16E0C5;
	Thu, 17 Sep 2020 05:25:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5694B6E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 05:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd2meILjMUao50aTwUMcTmpEA4/KqP0lZCBwiBvm1Q8r4NJNm+Lrnwii5Wd/Pn1oIEAqCF8o0f+S0c96KCdEGO1fLe0upEBSV6iwCdUqsc0KKt+vFpAK2cwwOC2glblUMKeUjWKcpOFawwAFwgAS3vkiHsRfscYldGM9ygvrcy22dHMD7c2fC1AuB1cp1pkkIpo4gOHyNbM/vjbVSyW8i+bOYPdEp5qZNEIDL4zrc2eF5etPEb1pAOEB4APNIFvkgAhapDrrN4X7j/i1gZDZti1JTQkDysPQj+kUY9nqdzlnomobnl5acSPiocKx8N/mAGla0EihrQn1VfqmXhV0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbxlj1qTAeOjb8zVYgITLRvsO51QV/m1DlVpztpRNzo=;
 b=QK3Ogfw8N5wqjSGZJ+lgIQuhUkG+mz25maH2WKMUKKZZO+02F/DbOfPObJ9GOhoSVjwuXVJAUDjqn1esHpJkKk105YLwfIF0Kcd0UmTDMXTzJ/ujwiNCsANId4XU9+6sFuA4sFattoQArwuMyNQiZfFiBo18tZRaWnnUVvJptzRvLBsPVApaZst79jPTSVTLaIRL8wM2M3YqFo9PSQpDjlyIklHxUbAYWpXOwRwPuNBz+gMqJFYciW3Xr9+DAbm0RKkb5/D9nDoiUp3kdbcw87vjgBbWqSTyPzXUA/GiQOiY3qUKJ3FNn5ySUIenvjkUKL8P6+x4Uj88JiLR6X86Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbxlj1qTAeOjb8zVYgITLRvsO51QV/m1DlVpztpRNzo=;
 b=RNVlX7kxk3Al0XLU7H0EECHbISzLz+rnPEQABleseIw2OGh05jY5IW4/LDHgcLSNa9qcQl5/A6nwGeUXYLFoN+66z0B98+EnJc7M3HfnaCEhkGTH+h6zgdFEirAiTIqZaFQZkZwz+klEiRHIaNkmlruC3LGkISzkDVs4Grc5u1g=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Thu, 17 Sep 2020 05:25:44 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 05:25:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: add device ID for sienna_cichlid (v2)
Thread-Topic: [PATCH 4/4] drm/amdgpu: add device ID for sienna_cichlid (v2)
Thread-Index: AQHWi41yoBKx+MwZpESIna1uBDoNLalsTrxg
Date: Thu, 17 Sep 2020 05:25:44 +0000
Message-ID: <DM6PR12MB4075219B40A94D6C853CC15EFC3E0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200915182409.68727-1-alexander.deucher@amd.com>
 <20200915182409.68727-4-alexander.deucher@amd.com>
In-Reply-To: <20200915182409.68727-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-17T05:25:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5a6cf11f-9cc2-44d3-8be6-0000802f407d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-17T05:25:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 44663805-7b5d-455f-b653-00002b93677c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-17T05:25:40Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9ee45602-3fb8-41e4-b1c2-000000cbd401
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45232557-d1d6-4bf9-3fc8-08d85aca2048
x-ms-traffictypediagnostic: DM6PR12MB3692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36927DB6ABECFBB6F4089A10FC3E0@DM6PR12MB3692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BzU8ZIpZrkaz9CR6VquGex1fVkAnla78b4UQBYU1wZaa2wiO0H3g+f+fFase9ujOI/FQkJQuxTQFTPCWlszPIxMF6GfwhLMPshMA83618ng6CCsGPP/W65dncAFbHkud2Dwg8H8H7L1y4+8xVqq69kwY5cw/h1xQ7rptejuBovsJE5r3m+aByaoU/ZVQjFfdj+U6jMC5YVnVDEFiBcsq7oUsRO7dcn4Ue7OrLYiVX9GNZpc/k2PdnIsM2LAa/86mDfJrl0EaNV5XqfUF/2mmc4d+iBf2+uBm84qDFhp4JcTGdzNVhiP1uzbsi/puNAVkN5AOvp72kSD/8ZCpakIMkJsng60FuPJaCcc9p6FwlYc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(478600001)(52536014)(9686003)(45080400002)(55016002)(4326008)(71200400001)(76116006)(316002)(33656002)(66946007)(64756008)(66476007)(66556008)(66446008)(54906003)(110136005)(5660300002)(26005)(966005)(86362001)(186003)(53546011)(2906002)(8676002)(7696005)(83380400001)(8936002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DPF35Du9SOPj4aPqQvJ3biIbaJ+HADuLIQZ5ApvfZKQUlO3m1o0jg42cfvoElUwhr6hfsCSFgh/YocDgMsnFblyp5nIGz5KTWpBqOqf8qjGZKVarRvzTifyfIei5JyIHyErXi5TBZtJDnSbP6PqnrjgXzFBQAvxHUvCL9My2uDGqtiv1HyLArM0u5Ioe3rLdZuGGDttmCA52leiJvQcfu4WI5IBE2ZFFIOx48tcYGlposNTmRPBlZhErUrEfhaXyZgp2U28eu9qKGKwIWusISb2DhShC3v1z1HClwP1JaG9k7kLV/x9wTbUgtn5qCWHx/u6f7VC/8NhLDsATdGuFcoQZrr/guucANZSg6f3pL6qKqv/h5Ny0gi6zA8iQBO2R3OFbtc2SP3/pX+pCg4AqBH8ZeXrqSbisvcHp1NLOBvXOpuD9GV72Lb1UJTWGNiPvMs+R2SmVmj/vOspxvDVIw/bIREiZr/UlUwowxXIBVWQQtVLtlQ60dGxi6snOZVsewdYx+v6YW3QspMozirEg3tgK9nA4WGpRuFvErSFLTAmUHFAVc6nkhj/JvJ+OI0Ex9yBE4s1VyF7s8rj3v0B+lETXSqY2j+nlbmYufFb2Su49pRsLA7AKlKoMWXCOwg7WgYXUzvmqe9QKFv7B6MrqrA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45232557-d1d6-4bf9-3fc8-08d85aca2048
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 05:25:44.3090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eF/7ahw6UwoJQqJVn14x76yaK2630zInWn7EbkR8VZ55ePz9ohKD5G17Vr7A1X50OMRaDxlzxgzaTiPBDPoYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, September 16, 2020 02:24
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add device ID for sienna_cichlid (v2)

From: Likun Gao <Likun.Gao@amd.com>

Add device ID for sienna_cichlid.

v2: squash in additional device ids.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6e4c860e8ae0..0bf22134f17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1076,6 +1076,14 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
 	{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
 
+	/* Sienna_Cichlid */
+	{0x1002, 0x73A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+
 	{0, 0, 0}
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C39a646982de54115a9ed08d859a493e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637357910685400641&amp;sdata=O1TxuMlHFiQFji8wrhbMI0MCCr50%2B95KTPjp2hMoB18%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
