Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E8C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99C220791
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ymo+ID2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99C220791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1796EDF8;
	Fri, 30 Oct 2020 15:01:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADCA6EDF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 15:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7vOTsO/kM0Ml53J188nb9qUs4AtiFOYTcsP5GTcHNCOuWut0FF5F+xDSaSw7gu3eH6eCjzrIVGKfiH3loSBT99pmd67bA7rlq79qnZaxmWaOWGQg7NKKZOEdtI+jVcGKKb96P5cRyROg+L6TFMisWsVyL+pe46i7djwtp9Voun+0/7bTNbSRfOOIBE/40SCEaRthe0EmwJXLWftCTZ3o78N21iXWWakBhqJezsMZU5EaMVuKQle1OZDeF75Yc3oaYyMinsSa7iZ3z0l54b7IVdpQfLTgEfrqqpV58YfdjAB9VymBIe+tNUFueekARsvT5jVCPoRlIvfE/amiBupPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUY3Z+L9ISA/q/Glii68HzXIHCUsUeVZSo0cNnXrRYk=;
 b=dP7kQLTj4ei6yhrdXT2h+LlCfDhmmaBS9x1YqVN9uCEBqHJmIK9R5l/a1Zw8qN3Z7RpMiLxxlxqVK20POyrNfXJMvUjmTO0htp1TxZSkNgkuQvHs4ImrUVzoUH3hvQz50fqJT4PThbgwALPHV1lBy5p4BESF3FIPKYvG1HMhXeOzBFknGoP/3L4OcTj7/n/qVvV0MfQpRXW3iOFdL5iL76PJRW/6CtyAw8o2EZ5GV4dc1Day0UeQ4+XtUGnqX5PSwnunNLOrEYg14zWH79i6cR+Q+TwtahgkgHabEFExcLbdDfQ/QwQR0j5hxqpsdebqz4rYRXgnGl0ICO4FzhZDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUY3Z+L9ISA/q/Glii68HzXIHCUsUeVZSo0cNnXrRYk=;
 b=ymo+ID2+dFK/oCyVsNBJ1hiHwz/QPcJbyQBuHHPaQfyJ3BNot43Yl4cSP4C/UWXeS4D3bxcbds06jDYWBeq0xJqlJsL/neAofCVa6epXDr7k0sreOxmfvR10Q3lJTxXYiD0Rf7KjhDFW/Wj2afvnRWOH+4e8ilAPtsM5qsQSWkc=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 30 Oct
 2020 15:01:35 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::85be:93a4:6d6b:e7b0]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::85be:93a4:6d6b:e7b0%9]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 15:01:35 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Topic: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Index: AQHWrs0E8j+f0jAduEG9n87LJtnJmKmwPW5g
Date: Fri, 30 Oct 2020 15:01:35 +0000
Message-ID: <CH2PR12MB4326F99F53975B24E59D27CAEA150@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20201030145722.132135-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201030145722.132135-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7a8b5d4c-a953-4737-900f-8de3edfc3fef;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-30T15:01:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.195.2.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0204f23-dc79-433e-18bf-08d87ce4b22b
x-ms-traffictypediagnostic: CH2PR12MB3992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB399237E3BA0F34E0818963AEEA150@CH2PR12MB3992.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qh/kqvDSp7x+jTby12qBR0UT+WOJjrPZm9nsaNergsv+u9f1P9d1Ukw9b0RlUswtQoznC+eCXDrzzfdij35e+mLvZe3BjTg0MBgtRCEJbgZgWOyjtXJ+75l2XFCvFD7M0IRiijl8wealT1ikhuSUSOjzoJlWbeEDxKj6uhUx2cHEzEBonlJNGL/stvihp3o11qqY9lyqIIkvXs7piLTSpUBeOsufenZdqiSWGZhS+gED3qRtfX4r0fYtN1I3D1QIo+CrnXleCjOWNtZ51Ehn+EJurFp6VGICfEQ4kxl33HsZC5HYkfLMstHk0TSCWfnd7T+ap+RRcWbIpI2sTm0eFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(83380400001)(71200400001)(9686003)(55016002)(478600001)(76116006)(5660300002)(4326008)(2906002)(8676002)(66946007)(7696005)(6506007)(53546011)(52536014)(186003)(66556008)(316002)(64756008)(66446008)(66476007)(110136005)(54906003)(26005)(86362001)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 97neixoDBitXVgXbo6UJMLJyKUTP1eLVRyWirFlylWpQgl9beCz91JGKxfE7a8Ib2MCaJDq9LAmdBK7D/MBH5/gtz6k96PGdBz26UOq/y/SmZp3Rh69Xqxf/HZSkV/f2ChAnkc3NcYzjfgYStZQEJNSBXklbVPGQzlUkpn7Ue8dCKcw2K5XPANih0zhdQlZYgaMBtVUlA263hFus3+EmADZcPhFEJvkjcb8rpH+LzMjqtXeJUQVjGoj+fJmHgMO7GadZCphRHBsWHmga0kug35s0kWT4ujdCbcW3Mh6UU8HriiZ9ljyTZuEEosgH1oLlwhPUyBhyiG0OX6s/aqN7jzgJZxCEmJuL3O39FXH1WOPwfDWsazM7Gm2Jq5a8ZqvOSBq5r8wygA9xtNy/7cdamWfmdEyDm8CbmZCjMNE9kVl5ee2zHRrvCIhzTRZuwUkbdHfBN/uGZw4Ql3UjtG2F4wDTZU6Qnhakgn+14ZqFBZ8A7pp7vilo+hPDCI0NkeeoVnCGjV3GoXPCpth4SRbi8VSl0opGaGWvh/f2d4F/9MLYUJiSuoKLQ1gZMXsno4JK7I8Es01g3DFgZ5C+HRWD+DQlj6csmnsiTz3Hi/ehLscZxWORl2vdUkkBrBDV+/Bc+p2tTWQ8geCP+f71mPEttg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0204f23-dc79-433e-18bf-08d87ce4b22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 15:01:35.5018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tzcAdC4nXMSzq63gcC5wRLszOXDhVdUMJt2e6dv8M/1jSZvddl1t5pz5zCJH5oF1MF+L1I5o7sDKiKMfd2upw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Please ignore the change.

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Friday, October 30, 2020 10:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhu, James <James.Zhu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy

Toggle on/off gfxoff during video playback to fix gpu hang.

v2: change sequence to be more compatible with original code.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I5b938c446884268c2cda0801121a53da980e603a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 277a8435dd06..ef0878e848de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 }

 if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+amdgpu_gfx_off_ctrl(adev, true);
 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
        AMD_PG_STATE_GATE);
 } else {
@@ -370,7 +371,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 struct amdgpu_device *adev = ring->adev;

 atomic_inc(&adev->vcn.total_submission_cnt);
-cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+if (!cancel_delayed_work_sync(&adev->vcn.idle_work);)
+amdgpu_gfx_off_ctrl(adev, false);

 mutex_lock(&adev->vcn.vcn_pg_lock);
 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
