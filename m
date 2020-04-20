Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76777C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F3221927
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QiDcq6VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F3221927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAD389B61;
	Mon, 20 Apr 2020 08:10:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACF989B61
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 08:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEAXfdpbVdbcQNKtIZCp1IRZqhpEmSIUtd6hucQgHePQJ/cg0GhEVf8Bl/oOnIE5aqLQAMuOlNM/tUDN9iMXQsRa5cPZOB7QyaNSg1cUBFezPKvhKp5/bceTT3X75Wv4ehkY4h3vQrPdkgLQ0zFfKQldJKOFYRonw3r5j8dMVL/m1WpPTld3YkPoqCo8njMbUtRNbNkK2+Q7H5gRGH3uvgjb5MmDA9ZF+z73njomVnW5/6Iy324RHMjQwRiLJ875XW5exyYCbk3ALlaHl8d5/X5wKFQtKergwEtlGWyG9tTR3k6T5BhhZNWr4ON4cQs3JmBTLOXutHkhUFkhq9eJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gglgMP6V2uvkxK2SwQHJIoDwn7/KZJXJlHPnfqqx/eY=;
 b=bcYLRL0+gbg4mqsqimQJ/a9uiqf4ewusa8Eg1u5noUlUnEOBOtdyj0flH2lv3Bh8vE9uynqw++JbjudyGA1PuKZ6u9DLekNKzdXtfD0LyFywO/votwFoMIf/YLCw110cMtuHneRe/39mEooMY2GqZxsi0EdeJ8PCPhaa05e7UtaCcAggUlDRwbI5XJdx2UuTtAeEWwuE1ch1SMQOUU6w5Wiflj1QQOiPvW95ZkZdJXxG4lPNA4fpSLOr5eSaJ6UzhIzogZdzkJbUY6HH3JeSR/P/EjoTtb5bNEMQNkmm/dDKtgIOyRCvXMYUhn3/Med1LPSfl92LZofNqH/gQuy79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gglgMP6V2uvkxK2SwQHJIoDwn7/KZJXJlHPnfqqx/eY=;
 b=QiDcq6VLqqdIjipT3PjN/Qi4mwn7i5bHtzArtKKZdefv6KcmG7zk6TGLmYjAFBxRpxEJC2OW46sFX1ERkmoutTpF6706g+MU4HYNDQRckdao7UT0QZ5F2EHS0XYMiCb+O8RLkK1q2IvKJp8Aw2JHYiTx9er50KnQLvOXZzLiaII=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Mon, 20 Apr 2020 08:10:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 08:10:39 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: limit smu support to Arcturus for onevf
Thread-Topic: [PATCH] drm/amd/powerplay: limit smu support to Arcturus for
 onevf
Thread-Index: AQHWFup1dcN0hAJaMESWcO9kp8XPyKiBqGbw
Date: Mon, 20 Apr 2020 08:10:39 +0000
Message-ID: <DM6PR12MB2619B995B90C34A2AEA4BBF5E4D40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200420080500.26212-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200420080500.26212-1-Jiansong.Chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=199ccc46-ba64-4cb6-8256-000038cb6e22;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-20T08:10:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e4af714-f859-45e1-c3d3-08d7e5025079
x-ms-traffictypediagnostic: DM6PR12MB4057:|DM6PR12MB4057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4057666367D7D05D2F5CA4DFE4D40@DM6PR12MB4057.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(186003)(8936002)(110136005)(54906003)(4326008)(316002)(7696005)(6506007)(53546011)(2906002)(76116006)(26005)(86362001)(5660300002)(8676002)(55016002)(71200400001)(33656002)(478600001)(66476007)(81156014)(66946007)(9686003)(66446008)(64756008)(52536014)(66556008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZCzlQXPvF8ZnD2FvMBvVI8jsWTWeTWLQik4fAvQ5/NlQfoSMSr4PR+ABJy4TctwawOr9Xda123IHzf9G6uSjljUNR6NGgjxNK3fM+1rGpe+lNH2chgbqWWJZCk878x+IxfjCZl3BCi7Gr+/g79BTB1DI/yIdbrQV+LSvKCUDG8IuISRd7q3lX/D5lOjKqip1KUttZ3oBudONzQqRWFDm5bsiLjB2FnDw0gI3IBO3/L4uhSZv0BkFd68K+9/V4DOlGMuct6YpfIk5QsGIPfqV2RRVqBCQIWxoeNMpw0PQ72hFElE5QxaipbluNVIaP4VnVbUuHBI+Q9vv7/PlVeJ4f394ppBlIPnNOH6l6uvlr19eMN6XrOkOuAjGBhk5XAFZ3Ry6jqsNbgqaTBwvh+0bcCg2lX+piojVGYDAiWeKJZhSIr2Uu6ixzDGm25Mx5Bc
x-ms-exchange-antispam-messagedata: 3GLGLpd6eKGVPI639VAD2zdrt0wyMeRwyE7SNxkK1BB0jV4TpwFE+s21gA48DoLh9A9H1oB0u92t20R62LVsHfwtecOYS0xWgItJcs9lfyGOwx+MhqZO9oMvb10G1y6AoeYzrwvQNZaUonTbJOzYHQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4af714-f859-45e1-c3d3-08d7e5025079
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 08:10:39.7837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ntJNHE6ac1i6bGv1BsE9nRQrg5CMQMTaScdtrR8+q67Yoj7Gn4y1ApeHZOrA8ue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>
-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Monday, April 20, 2020 4:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/powerplay: limit smu support to Arcturus for onevf

Under onevf mode the smu support to other chips is not well verified yet.

Change-Id: Idbc166bea203cabba7615a255541eb283f18e1a0
Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d4599fa6dc0b..88b4e5642302 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -571,7 +571,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
 	else if (adev->asic_type >= CHIP_ARCTURUS) {
-		if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		if (amdgpu_sriov_vf(adev) &&
+		    !(adev->asic_type == CHIP_ARCTURUS &&
+		      amdgpu_sriov_is_pp_one_vf(adev)))
+
 			return false;
 		else
 			return true;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
