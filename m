Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F280C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 06:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA84206A1
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 06:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gB1xLD3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA84206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A8989A4A;
	Wed,  8 Apr 2020 06:51:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC873895D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 06:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/j0TAjawUnu3RNqp73+oTPAgFpvSP+5FVr+YwC2LagBbCTHFka/NjwPdIEs2r36g1E7ZCTq+cqUf/xNZbUygRS2aQtAF70huS1wKhX4D/OfvKQ6iMq0j2Ntbku8hXzbNH8yKGQYF9gRLQWZL6Jj5D7BMad+O27+g8iQT5Bh6MjdrhcDAEQdLpzsg6z75U9voLiUqR4FGGllrDNgne8dNpH3q013zZJvbo0bnOcLEyuMlxdNdJ6MkR7JHL7LjPBuCM2zEUIXvwLx+BM+IiMRBhUlc/l9f7DYxG7jksA5Bjdpo6pjZdC/X0X75CGoO8qfXhvahIJlEz3sb1e6AgvZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+2Rs75NpzL3en+9AVtnzNMKOuDNZepbk3do+NZzT/Y=;
 b=RFz4HCAVycAITZHWSWjrg3D2pzWbGLi+JL6BtEQUR+STnLUi21xtE3HzfEQW14XfgWcviE9KOrkyvS9w0ZLamYACqeBqg0UIbDFwxowxyEXCpNvl/vz6HCU1RhBBJ4pZRukW9gzKwzTWkYXPc0cKQQysqsUoV5mbv1dwJBZvJarrWzFX9Ee0KXB/MwAGW0730Gm6a8Ogx5WSVxExzq+pmBCRevhEgeGXptxnbomEH84I63S66kw2TC12qhAN92VlhjUtypbuakWFySvjz65FIoj/yoh5Wmqg4V9OwErhr6XUfUPhmZ44kbW7oeyYskNkDZ7PUP468M8/1zlqLmCKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+2Rs75NpzL3en+9AVtnzNMKOuDNZepbk3do+NZzT/Y=;
 b=gB1xLD3TeXHDMyXK2MedjTyTNGKYoYF+x/gkCuTXwy9hymM4i6IxqppAgCCwPjDuU5rnTwh4BD7qu3iB8Fu+jafp5IoT/EZElAZ1s0zYuS/f/loWsazQuoX9YXrk+IP68fJ7NK1X1k4ItfMTLCQbYxDFLEpYnEMRCmlMGSNhBNI=
Received: from BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Wed, 8 Apr
 2020 06:51:16 +0000
Received: from BY5PR12MB4065.namprd12.prod.outlook.com
 ([fe80::258b:7593:6929:c5a8]) by BY5PR12MB4065.namprd12.prod.outlook.com
 ([fe80::258b:7593:6929:c5a8%6]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 06:51:16 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Thread-Topic: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Thread-Index: AQHWDXFiiC+hnDtGE0GppyTIeT4pL6huyKBQ
Date: Wed, 8 Apr 2020 06:51:15 +0000
Message-ID: <BY5PR12MB4065F16970D44C6FD38C06E78DC00@BY5PR12MB4065.namprd12.prod.outlook.com>
References: <20200408064548.857-1-aaron.liu@amd.com>
In-Reply-To: <20200408064548.857-1-aaron.liu@amd.com>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-08T06:51:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0e8c175f-41a7-4e79-82f3-000054e8ca81;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-08T06:51:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3708d331-14dd-4807-a262-0000be58a196
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdf8612d-6c6f-4235-f62e-08d7db893c2a
x-ms-traffictypediagnostic: BY5PR12MB4099:|BY5PR12MB4099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40994143456901E41C874EC08DC00@BY5PR12MB4099.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(55016002)(52536014)(9686003)(54906003)(26005)(33656002)(2906002)(478600001)(110136005)(81166007)(6506007)(5660300002)(53546011)(81156014)(64756008)(186003)(76116006)(71200400001)(4326008)(66446008)(8676002)(66556008)(66476007)(86362001)(66946007)(8936002)(7696005)(316002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 29sLQetH8y37VdN5Y0tudL/mtMGh7u42/5Ir6wQq12DNyMPCp25heqeuJhYib/632KQxgQGbd2LqdYK6OtjyNky0S/mS3o2S+Ddd9xE+zmA2aWC1bfgz6YOyzoM+xGRup8PCyUmdwedEpRVXgq1Z40nl2meggZyp0fzfBvmyP0TmaOfbwWOjb6praJL+8/qKnfGb24ItebHMHyFtQOuWaemMGyedQGWXkccb9cqAdgr2DsN+MHwAzB7hcH56K15GaaSsdLnx+eZ0I5xtcaF2uS8bPIdfGs+yNCTv3KeZUUnvktmUbQ5SnENIOWzddIq4sLQLnLF3R0MQQMIv0V3ItXa+5dBU3NvR6VYIwKU/FJoJROoqNE+xl/KwnSsuVxY1/NI9L8SDoHMeBOST4ThO2cm5mgs4KFbEkuighFfKIomIPAuRupUslNCx8MipbJuR
x-ms-exchange-antispam-messagedata: h5LkBZpCD48Jj4sXWZeMO65SeMzpZgXUhTepME382H1d35Qbc9wD/iKYjImeUVzjVV6tObgwUNyo95+i9IpiJsPpPzUEbkqs0//cOGQOCI2hfLyN4ovsdHmJEvx7MHt1VZqG8LrTtLN90BHk6aFDqg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf8612d-6c6f-4235-f62e-08d7db893c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 06:51:16.0992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOcxyePjFoSvgz39jz1CUkDQWs2WuJpf31WphSEB4kktcPGQaaUdXnX9INhol1GeU/j4Il4515RZUJ/9Ej7pug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com> 
Sent: Wednesday, April 8, 2020 2:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Dai, Yuxian (David) <Yuxian.Dai@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics

Make the fw_write_wait default case true since presumably all new
gfx9 asics will have updated firmware. That is using unique WAIT_REG_MEM packet with opration=1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2d56b06722bc..1d18447129b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1214,6 +1214,8 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 			adev->gfx.mec_fw_write_wait = true;
 		break;
 	default:
+		adev->gfx.me_fw_write_wait = true;
+		adev->gfx.mec_fw_write_wait = true;
 		break;
 	}
 }
	[David]:
-             >much better solution
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
