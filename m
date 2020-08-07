Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E6C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 03:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B722086A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 03:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pARhUEzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B722086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93536E03C;
	Fri,  7 Aug 2020 03:22:24 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700060.outbound.protection.outlook.com [40.107.70.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25BA6E03C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 03:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhKBFyJ/ZXyDiCN6CDoMgR8eSRhTxXuxQSNCmpRX+Qx9I9WY7n0qj7H8/LX/6Sio2xz3sF64FnWfw18AngmgJMhLSp+Pq22Jx1uDDLaoMhaIcguEUFeX4PXOQrdqi26j7GLXwwTLaiTtBMccJlPa9FEPUpxJkdgXUOCOyIjA95BW9S1AE3zWkev0mf61FLTtV6UhN6JUcmd16AVq7BQ64WwnICZC/joMuzmjTzoJOSkXw1hug1e3EoKY21UMOJhfq+1NdFLxC107Z842uR/eDdqldQHAkNuqvS7GirkrOmQ5nKpfHHK8R44lk6USOiVk63qyziHCl8THd51PAmLSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKnqgLcMGiM3/UHi3uGQ4WgRZKK08kPizeqZzqcbQME=;
 b=UebTM1re7YWVxPD2Bjt89kKb7opI6IBxvCPor31k+FYzXBS7/AjGycN3wmAKrSCM2Wg5FR+z3T3NEcvRj8veYeeTpuVwACLE9cHNckMpE61zoonA7cgqwDlTSVYJ9oeW2lWj8JT8WduaaBCM7zqWeQY/ZrxGGNhawNoSwLSOrB3Y32Pw/0PWg5dQ5lXJiW2+2bNz0WNEBO/CzIFY0cJL1SbDbD+oWwjq7XIef3suKSo/tiD2kRZ6HkbZUWgODynchVPFH6LOWyWtB03SQeCjwJWepu6O1n8ZNhUdVhFfRRaTnLVG2omHLwjw5fo1pClDtaSH21cPnW8ctAm7krLf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKnqgLcMGiM3/UHi3uGQ4WgRZKK08kPizeqZzqcbQME=;
 b=pARhUEzLrCRyxOBupMw0YiWPNCtyLED9PGobHlroM9F+XqdDw8njUFfRweCC/37+06TOMiw/4F7Yy92hMxO3skvJj6ds20M84aC+CJGp/j8HpgKvBbQJgxZNxIB2kyFeG/xj//hPaytjUtGNi7QrhcRT+aND9w7ZZNjC1bapM7k=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2501.namprd12.prod.outlook.com (2603:10b6:4:b4::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Fri, 7 Aug 2020 03:22:22 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:22:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit(v3)
Thread-Topic: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on
 Navi1x after GFXOFF exit(v3)
Thread-Index: AQHWbGOZtznU3Ydjp0a+p6yag//Xgqkr+mig
Date: Fri, 7 Aug 2020 03:22:21 +0000
Message-ID: <DM6PR12MB40754BAB094DE7D9289E6CA0FC490@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200807023633.5949-1-tianci.yin@amd.com>
 <20200807023633.5949-2-tianci.yin@amd.com>
In-Reply-To: <20200807023633.5949-2-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-07T03:22:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=00da3a3e-a064-406d-a0f5-00004b229549;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-07T03:22:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b1e67a85-83b2-4195-81ac-0000e75bfedd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-07T03:22:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 48d67eb5-16de-421d-81a4-00007cf7c459
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91e46b2b-b4ad-46ff-3251-08d83a811926
x-ms-traffictypediagnostic: DM5PR12MB2501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB250152EA38B1185D4132CE9AFC490@DM5PR12MB2501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tOelgx57hDc6+SulL6YXloBjDQxv5byebNi7YOVw0TvoM+nneI7tYbz803CGHJhcbeUvMnr0uc1pHoDfkYg8fem3ZrVOdITsaT7Z2IhRoqtX2/b4KnlTdz3qDye1znxcnrRM46eMi795/dpT3yb0C5BXkamsO5Hja6B/BsmDhLxHjtmDTxNn8ovord49z9rBk5o/cB0tOa2qf//5vrhSrULwm/pjuAIpTeA0TYht7OSPjX8LX/0YcE9hgUW2lLefye7UY0Zvr+9qgXZScKvW9RYDBX1UShspF7zV074D9D1Fuil0u/BeMkwmmBAW5tgjNGR4NMEn8d+bbxnDi0/SfSoyOJbXwJWDWqx2tPtGWUWO7GXbopJNme1AwKjX5dJ4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(76116006)(66476007)(9686003)(86362001)(66946007)(316002)(66556008)(8936002)(83380400001)(64756008)(52536014)(55016002)(4326008)(66446008)(54906003)(71200400001)(478600001)(2906002)(7696005)(26005)(53546011)(33656002)(5660300002)(186003)(8676002)(110136005)(6506007)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bdtAynA5xP95G2nWLepyvwNPPk1V/qhZ4ka91oIFByDMaDdx0Jq/clhTfcqU7f2Zh6evJc7LOZgditjIl3RCUNR/z2hnFTpRgBrj29kmHP06Js4A3fl8yAiYg0fyCx7fWt6yui9UvypD/Emsp5gVFtctQt7htwNC2b05xnxDtwH+zs42cy/T23CqOI0PRj/7r0IZicnWJ7FbcqvvFo+6ouUS/r6Pk2dHkh93LCaa0cDT4WMjHZVv1FNfpeEc7kDDnsnOg2a8dPcnPLnB3nR4ScM/GAKnFicIGrsNtrHStTz59w2rmyAlmRJqi501am+WkrCc81ZL3aVxvK586FKA6eChnO5lzqpwufSm9BX/T4JmcuUHaKf4eGWpGus8M5aVi8XQf9xJbP3RzDkce01d4mOylkioi1TcOhziuWYsKe3gnMeChCskhgLQOuGpnmmVHfih2rPaGOIHgw6FvOfRI5nzgi2jOejvjZsZl/roC5XLa93kEey73AJdrfhjh2oqlKditPiYLh5ID36JJ+5jsrVu5eNIIhmGeWu3vbKIePJNlrv+uh4hXrEai/WsKqq2EVSI+nID3AtBsEHOAL35aeccxAjupQONsp+d7Vsng7/j7yMVclgceiGA5i38SJ7kh3UHAbSfal8TTnWirROYFA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e46b2b-b4ad-46ff-3251-08d83a811926
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:22:21.6496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYo5WxZWDy+aiKksPV1OmRF1lthKs4vxhLUFY26RTKboUcnAPO839d537ROwzy/cabGQ4Mrjxb5PmPqY2rlJpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Yin, Tianci
 \(Rico\)" <Tianci.Yin@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Hesik,
 Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com> 
Sent: Friday, August 7, 2020 10:37
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit(v3)

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings are lost after GFXOFF enter/exit, so reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8eff0173360d..9e133fd0372d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -571,8 +571,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 	if (enable && !adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
 		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
 	} else if (!enable && adev->gfx.gfx_off_state) {
-		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false))
+		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, 
+false)) {
 			adev->gfx.gfx_off_state = false;
+
+			if (adev->gfx.funcs->init_spm_golden) {
+				dev_dbg(adev->dev, "GFXOFF is disabled, re-init SPM golden settings\n");
+				amdgpu_gfx_init_spm_golden(adev);
+			}
+		}
 	}
 
 	mutex_unlock(&adev->gfx.gfx_off_mutex);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
