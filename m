Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251E9C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892582076D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EV7UQCLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892582076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE20F6E11E;
	Fri, 30 Oct 2020 11:43:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1166E11E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfE27CDKZJ9ItaacsJLp3COvrkbE8+odyUq+zYbpNvToKrzRtqNmUSQ9/FSUAiAnUL811UcnucjdQYtYRQSoP4IXzY91+CWkAT2tRx3DSnBjUbAn4QCxDDEy/aAZZ2kNwXG6/ILA84JG9kVUlYtxBy+hAvSN1WLs3sGGEXaIwfMWlaclOBcJd9T8J0UbLNlNuBCHfhx0ltJdOV3AsOAfJe9lIVzCclSAZVL7ugLXmMvqAMATF+7cbY2Qqh9B3/3L2GGiEwBHFtcYlv6A8J7/LUfZ1GZNfOMdvuJuFfw3az1Q/BZwMi+O4JNWEp3qmeWeIVcmZSxQ5/P7n3YEyVcb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBhiAL2qC16VSZobUl0p7aNFjbGFODFlTQV+kq9KqUs=;
 b=Kn8ucDaVZ+CteFgPSslS9dScXdC/TRCETlZlfiLJPt3yCQE8Ahmvy7Ujcdz9/q997xwwaxplHoLhhnyoeJ8SuRv+yKF/U6sKX0eh1/4zSv4cQ+daaBTb058TLWXbUd4EB1007fQqOYbX3otVaDB2dOcf7Bhzlx7pL8DwEPVB03MMLdXaoegyDGN494uYSDfuKZJ05VQflf0qHMjG9Mj58WaaWhJAYNaCJggZ8mKaVJC7iv/wmiXTl3FqPBAQ1IPKiXuxvCN2MyZ7vWj+iH4uM50Lz3jlwo6HoPka82NmuI8J157MBUJiFolR6CR4Kuy02Su7bvcIejlA46oP6dKplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBhiAL2qC16VSZobUl0p7aNFjbGFODFlTQV+kq9KqUs=;
 b=EV7UQCLzj6hgROi8ZrDQ/3YImsjvnWM6NwEelWSwk/OgVqeLqKTTD11Bdwp2IaMkdlqlsLKBS9Ccy69WvVX1zJw0IhWYzLiA0m0qvxa8zJvgyOjk45HRAkRLZZta/rRUUhc+CgQq6xg7zLO7AONbyUaHF904Cp8Ti3bBQFsqAak=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1450.namprd12.prod.outlook.com (2603:10b6:4:3::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.27; Fri, 30 Oct 2020 11:43:04 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 11:43:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Topic: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Index: AQHWrrEM4HyZSqlNc0CVTFBZ9wh/M6mwBdCQ
Date: Fri, 30 Oct 2020 11:43:03 +0000
Message-ID: <DM6PR12MB4075D648DD74AFB4C7342E9DFC150@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201030113710.14291-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201030113710.14291-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-30T11:42:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=88f1e702-c1de-4694-943c-0000bc18e649;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-30T11:42:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5ef5aa33-8e2d-48c0-bc75-000077665048
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-30T11:43:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1f8fa753-b78a-439b-9c10-00000d64c7f6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 346b8078-9f25-4be5-b592-08d87cc8f660
x-ms-traffictypediagnostic: DM5PR12MB1450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1450322DDB6375219204E1B1FC150@DM5PR12MB1450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjjQeABzMh8sKV0fsGDvnIYvsj1HnD4XbAJugWmruD6Of3e+8EIDiu6MAEBNu3TaGfcfFE7dQve7RnU5uCa/VZO2rRmVhr4XGfUirwhGY3qToj9TC9c5s2BU51BgzhA1andfzIUhMksZmsr4gXgAyo5sGVd2RCsf58Xxz+oEhOlGqka136P1oWcKyo8hy7hRI43hd29SSrSbYhGIb1+P4K+8R0YMcTYrBuA2/7zqIuIkrgna/QNtBiQNBdP79Ko7YQYVtY5Ud/bjNAMRybm4lytqLP1gsZeN9DUu67Dv6F0v1z14+8j8YsM1bqbCi2Aw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(26005)(8676002)(186003)(8936002)(7696005)(54906003)(5660300002)(4326008)(33656002)(6506007)(2906002)(110136005)(86362001)(53546011)(83380400001)(316002)(66946007)(66556008)(64756008)(66476007)(66446008)(55016002)(478600001)(9686003)(71200400001)(76116006)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JPQ00ynrDgI9JymLLmFEimMXoArE+Q8QFTctGTcZKY6sGOEKyctvtfhy+iEZcTX0G03LV5CzUnw25vcvM4weIxd7d7kGPKGd9oTUEgeORcTSHTjwjl6cQHrHIXX615DhHpOgF72ubIsPJHZEkUubOp0S1CWZDObjkHVMxPdeKXkWZsUXWkmlIHxT9IZDBpEtJAIaVSyIv/bcUmokOzpkMwpJaGufcCeuFd7HIVetYvkfqVwe6L43ilBsPKkNRWKmthYbSQFBmCfmoevr5ynivjx/BpvtzxhC/A9Eu+P15z69tmKoqmcbYTq1zmv3dwbbihcS4ALPH3WdNA3yKtcpKVgWugXzjCgQS2DX1iddkb2rhqEyihjNNN9WKgJVA2s7wPKeS9wNO8Y3xRufgsu6i3z3m71j48caB33nYWNF7TOj35W1DvXTdae5v9LthR2MAbtrwoqByZG8fzdl7+Ly0qDHt8mL15aYqTRyUIiE4u8ScgWQ+rwFk0Cz300cqlqMKHpKnOGaibrvXFBlqDmPpRFLF/m1xJfMve4oICHkgJlp2yA4S5E4dreueQknYd0kjbCM/sworJ1XCXj/m/tRXQdYc9n6H74FDgjLa2bC8BOLRr+B0atZ1kbGxfihwQdwptoDPpe5DoTTTcGlcMuDtg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346b8078-9f25-4be5-b592-08d87cc8f660
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 11:43:04.0153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVBP93ls3mQsTCTqalRHZOdnBZHAC2ybSJ2hOQ6QMqJ7+vRkSaguwtn00lUcMeng/czJgTJGcPVF1sfrLoVTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
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
 Leo" <Leo.Liu@amd.com>, "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Friday, October 30, 2020 19:37
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhu, James <James.Zhu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy

Toggle on/off gfxoff during video playback to fix gpu hang.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I5b938c446884268c2cda0801121a53da980e603a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 277a8435dd06..444b89413232 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 	} else {
@@ -368,13 +369,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)  {
 	struct amdgpu_device *adev = ring->adev;
+	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+	if (set_clocks) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+			AMD_PG_STATE_UNGATE);
+	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
