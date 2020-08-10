Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00FCC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 06:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467ED2073A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 06:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4YwGhyaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467ED2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E4D89E35;
	Mon, 10 Aug 2020 06:01:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4AD89E35
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 06:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xim+HdhHpad3tnb1Uleio8Rf/N8QmwuD8zFpHADRoyU24RKasZKjE8FPTLA842cL6nUfhAl03j3slhIXSMUwwof6QuGox9iR2s4f/xntUXyyWpNqnCEf7GARXOFUMVuhir2UTabxWORfgrnA7Nne2RwyvE1suYOPio5N33tOf/o6TIsnLCCWlaPnq5x7k6MOyHpc8Wj8n4Sp1tntw12iRLGtB66iqBfMQ9D5hbJSZLJxcmol0fgPXCbcULVugH+wNo01CwLsMJjzfjaXSQNqGgLnnjDfZCqY6lxXcw7V8Y4kzZ87oZmtN8JdNsDGsRsHrEUUQWOTCJxEgg3c3zbcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ANzRsclGbf/sk2ripmJ+3n5iekbjFgU8quDvuOuJGs=;
 b=Kq2DsG1gmU4Erz9/DcX82wZLNUhJU0CTQE+A+A/w5ShPxDvpfxOC3qTq+yU6ndzwe/3Ts/5GYOmS645fm2uIkH+tc0Bg4JqXfi2JacXpYvapb617cFTu14S6oKzX+QOuWbfE97xR+SsuY2BfBOyz3qw2O7gDSQv2vhRAi96fqO4APbblXd6/0ql23c34R+qiVQrplXUwxCU7lL9UpcCpRX7DMn8pFVASa0Lav+Xx7ls2ivyo9qAAafOgR740rmEX603XOSnmkFqDQYXEux4lpgcCw/US03owF4odnIW4DcylPFiUGKj3eGPvLkexfzUA2rBv1z4fluG4NtmPsE2twQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ANzRsclGbf/sk2ripmJ+3n5iekbjFgU8quDvuOuJGs=;
 b=4YwGhyaqFTFbu7OCsblJ3ymBVVOuVoSHhhkqhvxxvli6P879YV/ckjVF8t52KX9hxkC6ftE/D303fTkx5NIdWXEpZs9NTF576n4n3f48SFshlE2vRzC8cUR3c0S+vAiVlitXaYmEYQrFkGV7bKmSMp+S+iIG8LPKukosnCIy04c=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.20; Mon, 10 Aug 2020 06:01:44 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3261.023; Mon, 10 Aug 2020
 06:01:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add debugfs node to toggle ras error cnt
 harvest
Thread-Topic: [PATCH 2/2] drm/amdgpu: add debugfs node to toggle ras error cnt
 harvest
Thread-Index: AQHWbtZv9rvYObD71ku6EqDYULyBOakw2ZqA
Date: Mon, 10 Aug 2020 06:01:44 +0000
Message-ID: <DM6PR12MB40752683AAFA2982D4B273A0FC440@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200810052258.27961-1-guchun.chen@amd.com>
 <20200810052258.27961-2-guchun.chen@amd.com>
In-Reply-To: <20200810052258.27961-2-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-10T06:01:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=989ee9cb-76e2-4e9c-8ec7-00000ac359b3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-10T06:01:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8912310c-d4da-4172-8bf8-00009c0713c3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-10T06:01:42Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 7a61a653-e4d2-4211-9ced-00001028c814
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51063057-cf5a-4037-3d5e-08d83cf2dc4a
x-ms-traffictypediagnostic: DM5PR12MB1836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1836B7068CAA45C24FCF23CAFC440@DM5PR12MB1836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0AT9QXhiUsyqIeifmXd554NyJdGph3g5a8CtOVoA2nCS+RMXgZKmOOIJbP3mfekUkn0AQBQ9IgFJ6SkitNetiEgmXHsPg1w69ns+ewzepyxXlD0mwOPNHCHUua2MLG64So8nFWPzKPHN6pJTVRooaKlvL4X0KTNjsRvj/DYseWmyWLnbev+ZdVTQglGdaGRnVRZ6d3/1irgZ+Wf3XOJMTNn5qOJSg45Pf8KOHvS+2PujzRrOofbyQDfcmixXwvWjyXez7iKkJCffvLts8xIRp0IRlnYFYUMp27wa9QcU1WoP/746Ig/NoQZFM4CqTczyEmAQ62WQETTOxSWlyBCA7pTkKnh+AYX+dfoAaVv2zvJYYTBznlyaAgofwxiWhqCA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(186003)(2906002)(71200400001)(53546011)(6506007)(33656002)(26005)(316002)(7696005)(83380400001)(8936002)(66476007)(86362001)(64756008)(66556008)(6636002)(66946007)(8676002)(76116006)(55016002)(52536014)(9686003)(5660300002)(478600001)(66446008)(110136005)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: rdvfCOCM5Kp6ckcpS6nrpXceCMXnZD3Rbfric01cHyMb3jNYG7H93iiNgZawe5fTA6uNz+U3P5fGOtfT3BHwYO0DGOZC5BLv1aLTwaKgdNjoqT2cxEEU0ogy8GjV9JwrxLkvT60ijWWMSPW1CmCEc4IL046sT/LrcliJqvj2OPBzYlnNGBpZxeHXYcbbAZZ1K2XY0ykKOSIsk/aEu7luqqtEYHPJbDOeB2tbUQ4wPa87F6YELMf0po/aANzYedbmjNdWwYg29pVKuD/ac7vxzbUuJT+3hojLOioIws3muZuUtR1JayGwrMUTAnkGBfBEAe6G6RGsiWqckkTvD6/qsjgFyEsyAg7bwIaQGDrSp7+iB2uEZEPMCWUk3C7FclAZHZTwsJw7MSQh9E/PKq/W3757XTduHpMRiSwREkHJj8HX2VzOpx2S/mAUYjsz4AkI7StDILS/fpkjqWkM2BiTLZMGJswWVF79+JtoxHESsMKEqSOEBKH3KIwuqSYTVgJwK1jgAL5HIPER3zcgDZiQBVcorKb+kdjkkefN7vZ7kn2CdDqCWBo1NK/WWVJ2dGLKMcn3/U9wSQOQLYV4jOV3947zzwYmEBg7JwFrc3fsLQAKfamcodAO0n4Hpo1V7htMcrg0htWnb/jRdQujai7DHA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51063057-cf5a-4037-3d5e-08d83cf2dc4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 06:01:44.6847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRN7Lsa0NtPdOgK89STJotYQ+TPs6wKy1uOQypZ1WmfbToF69+bWVHOhrSTk3ICIpJMjwQ5q+vFCYClDIDOa0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, August 10, 2020 13:23
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add debugfs node to toggle ras error cnt harvest

Before ras recovery is issued, user could operate this debugfs node to enable/disable the harvest of all RAS IPs' ras error count registers, which will help keep hardware's registers'
status instead of cleaning up them.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e6978b8e2143..31df6bf2dc1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1215,6 +1215,13 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	 */
 	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, con->dir,
 				&con->reboot);
+
+	/*
+	 * User could set this not to clean up hardware's error count register
+	 * of RAS IPs during ras recovery.
+	 */
+	debugfs_create_bool("disable_ras_err_cnt_harvest", 0644,
+			con->dir, &con->disable_ras_err_cnt_harvest);
 }
 
 void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
