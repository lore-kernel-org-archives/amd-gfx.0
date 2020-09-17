Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4DDC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 06:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071E42078D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 06:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mem/CpbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071E42078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB1B6E0F2;
	Thu, 17 Sep 2020 06:00:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAEC6E0F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 06:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7B7/1haZIQvkAkT/VzZ2pNkJOTKCtjaGFTMuvWL+2/tszdYBxF6iUPhYWYVua9GdxYLPEEt0+i1U4VTzU4O61rMd1tg52/V2p2fh2tVuQig5v++cGvz6E8cKIZVHlroXoMOk/ox42iJMP0VaQEXf/hxJsDZDLgIkiPtDyH4+UbrW3VnNzKF007RcGqaWqmJTgRgR1Pi2Gs6oa/EBxMB0ANRLB37DoZi7hi9tgqtGo9/wenM8yXhR+1mLEUJ5Fdg5y7i416D/HFxIff4Ysmnn/9CmsyfKBHtkDbVcHRMWfXndVaRh6e8vX8VwVY3q8mEkoygJBzcnlW92IrV8j2y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=766XXGq1GwmAMbXEpJvinpDOM+FtMsfpHg/7zuhqEm4=;
 b=iyvLjSLgO8E+FKTwb60vOwwCMATH+hAIeLhzPD8xLFxaFLNX0rs+5wCsyukt8omp0Jr9sgTVCo/k3A1YfO22sTvnm42iiTNSttuzdgKsVdAJQ5Hb8GISPqP28maLWJHUMRTTqeB07POAR6k+zJ0JzIzkOvji+CaglvnWFXMuTgUHh6myrTOL8p3z5rOfozsRA60AlZrXEPUacStipRC0xbPLy0kKUNxwniNuEONAGq/px/2nsYKu7C2xA5hEoDbFigfTY7eFDuQXFxnaSjf75BmVLy01K0zVN7qd1KVFvu+wMUTBTb9USe7tTtUzffqbn/WMHscLegP8GV3GNp3pKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=766XXGq1GwmAMbXEpJvinpDOM+FtMsfpHg/7zuhqEm4=;
 b=Mem/CpbXCCkl6qNdR8mDFm+rodecYUzqlL82guJERkTWZHPNuVgFo9ewBusQ066H5F9Ljc0+6ipefxiLtCbqKCyzSwHN+lo6hm9ek+DzsqdCUcm9V26uwLgoBxSvg0x4FGnbCcxcIawQs+rtowmp+Hs3VqfsSWhvI8WsoAMC9f4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Thu, 17 Sep 2020 06:00:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 06:00:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove experimental flag from navi12
Thread-Topic: [PATCH] drm/amdgpu: remove experimental flag from navi12
Thread-Index: AQHWi40nMzNWn7CgUE6+DNAVHdInCKlsWG0w
Date: Thu, 17 Sep 2020 06:00:07 +0000
Message-ID: <DM6PR12MB26194B9176EF07025DA55343E43E0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200915182206.68607-1-alexander.deucher@amd.com>
In-Reply-To: <20200915182206.68607-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=324e2142-8a56-412d-a469-68a30420e2c1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-17T05:59:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaa80260-f44f-41ac-5a86-08d85aceee33
x-ms-traffictypediagnostic: DM6PR12MB3084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3084225D8B77065ADBCAD0D4E43E0@DM6PR12MB3084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6h4w2HOdYOOV9eBjAoRZhvAU7p6Ruvp9keyf0NWRtJ0FQvGepqLSEYzlSAAjgMtdvVldNcGiFm90KPc7nNAyQFcv9DcaWC5cuZHPIodm1ZNYjj2E0awwdiAFAHhauA1tMZYFuxhSe8ktsznIk2RdUD1NVl3zp/nyNZXTrq/p04gAx3QzoMKx5uEobZSJ7b55M/XgyJXGxsG/17c4bgfxeOQEKbMHVXm+GnrTB9m8iNRXnaSZ/AqnEtCPurdAMy956SFr5X8RYhrzy8zIwICjQFMmRk5MU0DddSlst8dtwtqVlkTBt4ZyUYM5JgPKEIVJ2+bPI4AQT3SB3TEBCUr5Q3RKKMME2va/9YNcaGfNw3k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(5660300002)(316002)(8676002)(186003)(52536014)(83380400001)(2906002)(966005)(7696005)(110136005)(45080400002)(478600001)(33656002)(86362001)(64756008)(71200400001)(66446008)(55016002)(66556008)(66946007)(66476007)(9686003)(76116006)(8936002)(53546011)(6506007)(4326008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wAOHi76xWQIae1rTA+5ad368P7S7rtXLBdkNxsuFzc+9G+UpRrvWW2KKKKS9t0vxea6NAfQ1OACYiMOiAnYGwUMvxZLbrhISU4O3jXWO+0ycDcHAetI+twgohXiGdgSRdEfyqyJHa2Wes27JoTuMID2gNB2o4RZAdmg2VX+I9uSWVdcJXeINnn+Yp7puDa9bF1v7Px+WjHZyIyiIZlYvvuUVg9lA0X8KouTkKe5dQgFHROF5CKhdP/hdNpQ2S7mY9SoOB06jWqjLe4seVv98jmHKRiNpmoPboW5YOSEieG6oGKE33otn9DaKd+qQLkSZ10Rp2zUtYXMWHOUsrXzPVu0PAPSi/dhqRUeBpqUYqDUiF2yK1fFulamcsvM9U6RTSOHETLXFK+xRS6EOhVlBlu9lk73i/zbJApPU5DESveCdOyg6VFzYgDWp2kdPu2Axw6EcgXBtoLF6GZuwFp3qvFmAWNz6NoXRLkBIOtBgwe/r+5Jsyia90mFnMo4Twbme1tGDCJq5p7oxa7gA78BNNjTNbr82bn1lIasDlSQ3yC7gGMdFHMkHrMo99N93wv6U8bIlh7hAuLSqTSjccnVBeYUsg636Co+DswIKkLVsGTEdbJAfD/87iK/ZWpXbELuXK3VaCX8jF4Re+vNhYXFvJA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa80260-f44f-41ac-5a86-08d85aceee33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 06:00:07.7211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFV3K48wPW9qe94mCIVvoYFxFuTYyPQzgtU2uJtm3Z2+Y9BUvifdTwNdVOhJfbqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, September 16, 2020 2:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove experimental flag from navi12

Navi12 has worked fine for a while now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d87d37c25329..6e4c860e8ae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1073,8 +1073,8 @@ static const struct pci_device_id pciidlist[] = {
 {0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},

 /* Navi12 */
-{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
-{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
+{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
+{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},

 {0, 0, 0}
 };
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C5b2949ea7e4e4338e9d808d859a4473b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637357909421982334&amp;sdata=Yg3L5axov9ttkHuMh%2BgRUlU%2BF49y8iSeZxWA0vhJNs4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
