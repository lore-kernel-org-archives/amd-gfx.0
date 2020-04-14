Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B5C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C275420656
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MaaaMfVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C275420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E41389D02;
	Tue, 14 Apr 2020 14:14:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A0C89D02
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZInS6KRpIHx3/ds1WIRVo0o8sLsOmLWZdKRE9xx6gxwqXfOTNPH4ulFF7AjTtYkrKQ7lFowTD5vnAwPzXcxzf2wk5TlaY2Cd5k8tkJ+IJXp919KljhorfeOiTgfDUBvPHN0mNh4AxtItzg17VrD23nRcqzirYVPt4BjCtHg7IvoFxq3ltSThuW+J2YwHIrUd4Kpfzvs9WHrHUDrA4a14+5r8I9srrStG3Sd94FP9az35glfKUSmz9r3V6zLQSSlC5/+8iJ+YA/OFX2atWN6A8a0WePViwKdmNQZPsB1WroTbnL+05sVrs4Als0ixxMBXiyU4hF1BJraj1WJPhzAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d9ARyaPyvV7Nuf0/P5GTcRGYZf35mioWXWa2RE87e0=;
 b=S5xpaEFBcXAWKqS5SF39+dYGZLbVGB6keK/70j9veNi7xDfase1x5knABvYtYlKyu08Zv7FjsrZAXjn/9TdoZj2dwLxRUQqxz6abk+OT0oYok1SWYOpRBDz248CMjSyoHu6Cl0I6lNS111zsV4uyXyAdyZhoVbwcF5RybRfPLSL8ikHeW8HEWr9dlwz18dD8bHi+z1DrHXRxUIICqwgi9v79a85Fm/d0qeamYEowzbLDAHO6gxjY7hNKXdnpvN1RchXroCYJidQL79CB+X4+7GAK7V5uT6T8/AedrEFonl0TnRgQhj1DljwR+92l+zfW1kO8ok/fCE0eW4l08cT1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d9ARyaPyvV7Nuf0/P5GTcRGYZf35mioWXWa2RE87e0=;
 b=MaaaMfVRcYL4JtrH4AN5EG6rrCwDjkLIDKGcnVg3nmnqadVJMqItvTNq8km9PqqJmyb/MRk7JP6DBtCoiXel1tRxgVMzr7a2LZABFMpZ1VVqD4vnCQQCgRKxKI/mfb9eDtPiD3XVurz4WOlFTECJmH6Z8niHwfZEcJDP2cyml08=
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 14:14:41 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::5a1:1ed8:9866:e1dc]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::5a1:1ed8:9866:e1dc%6]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 14:14:41 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Index: AQHWElT5MMa9hF5D/kyPXcmir4uROah4prDg
Date: Tue, 14 Apr 2020 14:14:40 +0000
Message-ID: <MN2PR12MB28967245C3230DA9033439B7FDDA0@MN2PR12MB2896.namprd12.prod.outlook.com>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T14:06:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e1994162-8b6f-430e-b0cd-0000ace9178a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T14:06:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 17c447d1-bf5a-4322-8484-00006e45a7f5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
x-originating-ip: [2408:8025:21a:6490:8887:6e6c:b6aa:ae82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1055f8b-7bac-49ef-06ef-08d7e07e2c5c
x-ms-traffictypediagnostic: MN2PR12MB4581:|MN2PR12MB4581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4581704993875B7BD0E80B0AFDDA0@MN2PR12MB4581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(86362001)(5660300002)(186003)(7696005)(8936002)(81156014)(52536014)(8676002)(66446008)(64756008)(66556008)(110136005)(66946007)(66476007)(33656002)(76116006)(2906002)(53546011)(6506007)(71200400001)(498600001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fkeRDVSKEsDDWQbBoet2smSDxfCXSMQk961AIKHTPXNAJpQ5dzYMbCFDgL7mktQvStFgaTs7OHJsJr4vveF4rf4IqRfk3g2xTN2Qd4EgBEM88ogsQeeYtKLNSzkb9rFysq/hPi/nhl8LrYrRcEYF/m1CeriQcOBGa1XxEv3xqE+8fnnzJPZpja8a54/SKRotTcWafqBbb8q5iJ3tO9WLWR2fOvgD9U+s0l4qtIHg+dQrRpvQLyWgXSu401eJtnuV2D/U8NkoG51sGkGkF2ugEMJ0qDYl7olRxDW0SmdQ8lQFfo70lttbIFwWjIzKX4fxFeUpC0XPlgxo2yGgNHbcDHZKz1DK1iPkt3ODYWq0OzSXGoab/LTN9vVaMJQtlqtyf5gITLjg7P2kCXarV1S/5e2MyzyVwrulRcRjrVno6WlFDYU4nqOWieUrOI7grsb1
x-ms-exchange-antispam-messagedata: j8S347JAIRAcewmKdYfJyAt/wkZDr9z9Pzdf98rttAQ5eOK9+1TTdduOwibK2oNgwYo5QSpEITxWb63afkaC0QXjwsGDuuCHPFzCFFCVf+mTePlkwS020yG+OU4tX+dcXqE5T6zWU5ph6w+xXxE81fUAjSzE3UXJEfkatVQDosYwYbZadkMWR/Woj2dHvsK/FpL5maDQb5LZHR8mdfh3hA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1055f8b-7bac-49ef-06ef-08d7e07e2c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 14:14:41.0054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFG61ychhhjW3shze2w3WyVisXPG+9niRti5JBskCLkZ5bojpCb4CdmHS96NTF1bpG+umzNisUdKsQkFGy/dMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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

[AMD Official Use Only - Internal Distribution Only]


Tested-by: changzhu <Changfeng.Zhu@amd.com>

BR,
Changfeng.

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com> 
Sent: Tuesday, April 14, 2020 8:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix gfxoff issue

Turn off gfxoff control when vcn is gated.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index dab34f6..aa9a7a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -369,9 +369,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_gfx_off_ctrl(adev, false);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+	if (adev->vcn.cur_state == AMD_PG_STATE_GATE) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+		       AMD_PG_STATE_UNGATE);
+	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-- 
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
