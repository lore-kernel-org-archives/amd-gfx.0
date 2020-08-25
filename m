Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC28CC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D9E20665
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ILnVl46S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D9E20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9926E0BE;
	Tue, 25 Aug 2020 14:13:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B126E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 14:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxQlo5h4xjIolq2kyNcip5Atn2BbWhrN9lnC7aYRJHXGprZ1ek0/f2dZXKOuagXVC9vERwgeL+C5cu97ZzyJojBL0jX0p5brlTDxvs8sy483AjahrWR+94XM+eiEBd8azN25U5tE7EnbujaK3YJJwvKuGl0vn6qskHy+MfvZUJGVZTBYkw6zfa3fbPOUTEas8sFfV9t8ik4Fxt+s86KUebhahNKGhasujPZ1CbnSqjjKvBzBe1h97UXHlzoeJSH5gK8OyHCDR/qFn/vQR9dJCZNZMKSzKZ2FzjvnkI8XMgRZkGKjO+5tlPU6AkT2muUa1caoj7xmCA9O5bQGPplCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRM7JjuzfLsf+o0vP+jcU1J4rPDpSr49eOjPzG3Ukdc=;
 b=YZNKB9OHfJWKopQXaLE1I/kzeIq9BaWVP74/hMmytXmBffi7UfK5EUgUdUUAFcfkrNoGYTOIRn2InLk9gCl3TrhrPwB2YTc4AHFeCkGkuQbtKw8AcX99/+iqRDvOr3Cu92geZEbIPs3w+rj2PTP950FrHeBjICvDm4ZR9ufZxMwF/w+HU68KDHldqfMcGcg2EKcx6Cw9XmxKfctmV/Bly90mf1OOVg1B1HYRzqt7iKy5JchbDdBtfVm/9xH88FBHNBXqdUUAkTZOfPY0dg1cWqjyO01t0Qcz3bRqo/5CjG7szperGM/zlq8ZKw8tgG4YtWSNHnI/YU/Xj70mOvO+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRM7JjuzfLsf+o0vP+jcU1J4rPDpSr49eOjPzG3Ukdc=;
 b=ILnVl46SZ4tPVlTvlBqt3MlRiDMaErPa4QjO/MsY7i36JUHhimpfa+qrQQmCbAmsHT9ImTIyaBw/FKIfJIBfdWWzxHJ5SOx4A93FSN8vC+ti3rwSplpPUZOFZV6UtPYiMsCmnQJTlUCmP3NvIbh1aCCT560LJLYcts0fxZSu29A=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 14:13:16 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 14:13:16 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report DC not supported if virtual display is
 enabled
Thread-Topic: [PATCH] drm/amdgpu: report DC not supported if virtual display
 is enabled
Thread-Index: AQHWeuYD9Z+q/+KkS0iE18UqKU5z5KlI3SGA
Date: Tue, 25 Aug 2020 14:13:15 +0000
Message-ID: <CY4PR12MB1287A49F16CDA99D56B5ABF1F1570@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200825134515.278350-1-alexander.deucher@amd.com>
In-Reply-To: <20200825134515.278350-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-25T14:12:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=50b4f8d4-f187-4ad9-b7ea-00002b7ef380;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-25T14:13:07Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ad5457dd-9b8b-4c58-960d-00006a0ca61d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [116.227.81.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc3780f2-28dc-4cf7-55ad-08d8490102a7
x-ms-traffictypediagnostic: CY4PR1201MB0119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0119BF06D3C8B2DB9DC90BE3F1570@CY4PR1201MB0119.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: er+2lSqrmI7eFYAmOFoBN+t+QXdZ9rfQdwXrvp03cY9fWZh6t/7Zx1A0wub1OdvcmXTcN9gA+TGmmWB6oMMe0lFicSD6wtdv33poKsViEOcDjtzoQGZW/jTVD/THPe4CUZ/x9EVOSaCP3BD/pD4M1WIkJguDT0+XiaR0rRDh9+pxeDfJ9pP6AcDcs83Sdqn6G4fl009CElX/zDAf16uWjj7Mvr7enfIh28X7WpEuLqxqNYJcm29XLG2hlCB/M1f0f51h9M3heZYoXyEFFnXIhcaaFHrdlkKlNh5wcUkFlP/+Wbpq9ZuW10BtABJCJm1j2pLUy0n/Pe9pgFSuqlnUn7APShpLKM/0bv4IIU6VgB8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(7696005)(186003)(6506007)(2906002)(76116006)(5660300002)(8676002)(4326008)(45080400002)(83380400001)(53546011)(55016002)(8936002)(64756008)(66556008)(66476007)(66946007)(33656002)(66446008)(9686003)(966005)(26005)(316002)(52536014)(86362001)(71200400001)(110136005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zehhBFpC+Ru9sDh1dnBQ0Ui1wOE1Nje6s0OeSXuHASGNW9S7jAm4Wybv0L6V+XMv3uZNKheWkSml0ma2y/6yRZ1OlO7TNVNhsMrcj4a/NHVZA1bCTar06ABeO0GNL7EZqcjjcXqkeab8hzpyKLExz/B9UHaWuYp++XKT3cGPtfAtujye7IZXv7OT16RhJyyD/dVswbBcU+N32UoSV3Trny3iLupm2ctFEGUgOZCcnWSZTMsdxTRoSHEQEamOPDh712IgQQp3oTxTI7No4SlQG8eyZ0ZWiy0EMU5sLxbinVAIyvAOl3cdq9klW8592Dxd2g4vk3Jf4r/QvcYbrVNVTNCOYD0bPKXnkBivUHBqDDs9vqwm8bX8OfPHz18PghC5tvfjreap1bcpZn9bPqkiMfasli2ZK4Qy0Wj5FV9W/376p9A4TwTWdwvkRv+TGQJZ1vXl2sQRjLIBUjSlhTEDIRb3fHpNp5TU2dl0bNHEFnyUgDtQQ8kNQeNRCnsDIUQlglfGqgRaknc6KLyQ4MsjtA3KTMBfnQASsTVZ0xr6pmZWsGB7kdkCNguMMyeJIKQzTfFRZV1phEe1KEVfO6fpjzzuwsTGSinp4LeUwSqumWlwxzidzuMTIzy9R4Kjlv7d0QVTiMFfUcT4RuRrfc3oRg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3780f2-28dc-4cf7-55ad-08d8490102a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 14:13:15.8282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjJsj0tt8j6+7mWgTTBM43hMyH2zCXgt5EGoHLONF60Cd7AK0Xsgx/Nrz1Gtyape1zlLeZaAtgDtksh0vGFC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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

[AMD Public Use]

Why not merging it to the same line of SRIOV check?

if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display )
	return false;

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, August 25, 2020 9:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: report DC not supported if virtual display is enabled

virtual display is non-atomic so report false to avoid checking atomic state and other atomic things at runtime.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a948edcc93c..19f1e8449986 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2864,6 +2864,9 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
+	if (adev->enable_virtual_display)
+		return false;
+
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
 }
 
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C6679ea962a8a4b5715cf08d848fd2469%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637339599368934081&amp;sdata=WMMrhLJ2qXKEr6gHMn0ydF2%2B3jxzUEZ3azRsjkgOXZI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
