Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C29C10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13599206F6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZHPzTi8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13599206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6801D89DBA;
	Tue, 24 Mar 2020 21:30:28 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690085.outbound.protection.outlook.com [40.107.69.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C70189DBA
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 21:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+g6WpHEuszJbnLs7XO7KZ76Jw0VrTR1rqObm9zp032zM3neBIdB/hAoU+kV6+aFFIJHNFOD0Sqh5zXu3anOKITeJtd+7IkZqRqqcYR9HAiVMlPSVqAJdpwYbyyeN8HnDXTP+G64SQyTqJ8K6+hqr8oiN7mslA43DZPoSLBDqOLo/wMByHwtn45DH780GYFbDXi7u11PwRjwceDrdYr2MWjzaXwds6NaMxAczWeqqNE1dx4SzVJkRac761SR0Z2l98ueAXWwJFsmTcnhtcNqtVrNCAzbJYkoFbv0XRjOCyHNCuP363wm6faNtsb91YaxdPkS2Tw1cWwVmoSFuWC8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZdkiuHAWwDk/E1Ok1BZXoGfkH2uOtlSY8yj8CMDol0=;
 b=aPHMBYHWkv+xuJ+/L7B+THLpo+6iDtko6aJUbXewcxQfnmuFp01gQx6TIbikGi+1rWGMpGmsscpl+XPlMcrsHBfXfS2SMWseZHipz5zsQeN+8q/N1wNALBiFoXOmvvGVsaXQkp4rM9i7n6MDXKfg2GFsww/ogWNLMFNpPt2P/8SNGlCO1K8QnRT5hHJnuiiRK31QkLKI0a2hsfvWjlMtYQwVzLrr354z+lZuAZ5cDgf0n9fkcrd4fo8RMRPyER83U5DI6Y85G8BXiRNywXmiZI5SKO8+xoKv/HocO1bVOzwLv7pO896+osB2OkZlUxZRjE4Ik3/ptaIYlO5MHCqxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZdkiuHAWwDk/E1Ok1BZXoGfkH2uOtlSY8yj8CMDol0=;
 b=ZHPzTi8yRYyRgM+thXKX+rniy2aYmEBMyrabHHfIwz+aa0FnCcSGmvQVpEP4h/B189e2ZtavStp93aPx0MF75hELdJ9iA65DDuX0xFbBoryZGcmNFjf805KeK/iioiN9G8xVoY1jKZeUS0B7pbWWrBY8m+vw76YmbMVvyugJKtY=
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 21:30:25 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::36:e79:de19:78a4]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::36:e79:de19:78a4%7]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 21:30:25 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add SOS FW version checking for CAP
Thread-Topic: [PATCH] drm/amdgpu: add SOS FW version checking for CAP
Thread-Index: AQHWAhVPTT18k+IPI0GAU4TZL13/B6hYQnVg
Date: Tue, 24 Mar 2020 21:30:25 +0000
Message-ID: <DM6PR12MB32419F00D9EE4FCE1DBF73EBF4F10@DM6PR12MB3241.namprd12.prod.outlook.com>
References: <20200324194745.8276-1-zhigang.luo@amd.com>
In-Reply-To: <20200324194745.8276-1-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-24T21:30:23Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=98a1050a-e1bc-4443-bdfc-0000301535a1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-24T21:30:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d67cc07f-c4b6-462d-90f4-0000312ffa60
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
x-originating-ip: [2607:fea8:3bc0:316:fd54:543d:6ec5:bac3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87a7c008-b97d-4128-9e7a-08d7d03a90e5
x-ms-traffictypediagnostic: DM6PR12MB4369:|DM6PR12MB4369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4369F2F5E2A2CF32E4F4CC96F4F10@DM6PR12MB4369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(186003)(71200400001)(55016002)(9686003)(86362001)(66476007)(76116006)(52536014)(66946007)(66446008)(64756008)(66556008)(81156014)(8676002)(7696005)(81166006)(316002)(110136005)(5660300002)(4326008)(966005)(53546011)(2906002)(478600001)(8936002)(33656002)(45080400002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4369;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXUWHbwsLDUwsCL/zRkLu2DxZVlXe5nbPx1j+YJAn+67lT8IwZfozlvtRpAICPjytPeUFrO6gYTCch9cMNnPEoyK3LABebWZfFKeDOYZpmP701Vzjast3kSqxI9TYbe2LPDLpdgEjfv139e3P9mejJEkoDFKJYUi4Jb+O4X5CD1HGTYqLdAmzddIws2sdNUDirB1Pc9TYO7XpgO4zZXfIoImvfPdCo0VRoNpWkfYF1B0yDkIKLWrybFAczlMFusb3ao8S4nNgCpohFsKgQ1bSJ6TZRRPa4C7Jc7DTH9PeBCYIzgpKGhtOIIohDO4mgMEmIHkmp9SiLUMbYVJuMpRIBVFMMLbvcfBSSxFjwE+zWhkBf9OjkhKz4bs2KKJ6XPjWtqds9Tn/IUf4VAGYylkb4RKSBOgaZWeXYdNZ4Mxn3JbumLnL+ix6+PRdKWdcLWc0mJqKnlWEIKZqnEbqwVSu5+nKrZ5iiXU3TW9z8tUr0o=
x-ms-exchange-antispam-messagedata: LhxDshvsUCJ8Ne4+Gsz37TtuAwUPui1smb1metMw9sdrOC58Ay8273DKYcR0YcCN6VQV3PPG3k0B0+lAUlecjOajCMPhNXSwIwg6c1sOn7ZtDuY19Jd7cuuGysY3oIIgY8mts+xiE+WSL6gtAOWsZpS+WwmtCuIFcOhs2UxhLDk8n7UVpey3wxU6RqTVt5fdytVqvQRI52hHLCt3wqYrww==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7c008-b97d-4128-9e7a-08d7d03a90e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 21:30:25.2773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uz9NZSHjGBAFfOvo0F/jEh5We0098T1UMSZg2Zrs0cYzJ/FfmrwLvjoVYVCt5Je89bSIQLzkMVb5wJKaBPO0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed by : Shaoyun.liu <Shaoyun.liu@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Tuesday, March 24, 2020 3:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: add SOS FW version checking for CAP

To make sure the CAP feature is supported by the SOS, add SOS FW version checking before loading the CAP FW.

Change-Id: I7aa1c09f9c117f67ede0db6cd5911d56c8568495
Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dc42086a672b..c2bf2d900039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1407,6 +1407,11 @@ static int psp_np_fw_load(struct psp_context *psp)
 		if (!ucode->fw)
 			continue;
 
+		if (ucode->ucode_id == AMDGPU_UCODE_ID_CAP &&
+		    (psp->sos_fw_version < 0x80F5B))
+			/* 0x80F5B is the first SOS FW version with CAP support */
+			continue;
+
 		if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
 		    (psp_smu_reload_quirk(psp) ||
 		     psp->autoload_supported ||
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CShaoyun.Liu%40amd.com%7Cfb1e9b3393764955cf6c08d7d02c48ec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637206761598725731&amp;sdata=v9YpU%2BAGlVcDvXLvKTjzqMD0Xwzo35diNdBt4O3QwPM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
