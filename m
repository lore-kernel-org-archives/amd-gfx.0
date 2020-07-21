Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBAC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C5720720
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vdkNBUOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C5720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5D86E1B2;
	Tue, 21 Jul 2020 09:04:12 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861F06E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/b2BYfI3ck+9XBwLr8SpZ2B68nK5N4g0+aRXbWhqjY2Qa3cKApc07xoks92nYU4Pc94wbf1s51RsDiVYsBV0M9FnhMgEavM6nqzRF3l3i95HCpvn/KyZHfzqsQa+aG+uqYwydu5eLw6D4N7BO3ewT1kMEdGRtYvYJ3iaMtaJ09MzIg7heXHHHMEUhwzciHhRxcwxHjZQCq9OeI8WRQN6SpiWWPtf++ME9n2JXSl/uXe1LBEdyRFzKb2H95jzZNvtJd6eOxKPrTYJK0EsftaGle65ikb2OdLYhsNar91Mue/j8BHnX45hdxWMBqjMLqiq2c5sDV2Ol5yvCs5eRqu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu3RhJDHK8NQ/BTc9RIVa9DVYAze0B7XiuFgHmNFtWg=;
 b=VEAvxG5UwZK773i4Vb05yUMRTIyagCbCUBhz0pQi51Z2CLnP6Hcovzjx23C/hl9/gOWHoYF/Jo/rR9eU1U1d/Kj6+XBxViHKamHHzgp75+uHfr0fin4fMydKj155kZ+Y20mIHr4zfkeLSiUwL6iJMCyIvvOOgENu2u5I8M6pbFk1j6A37/8eW8QbeAS6zBVlDIT/bpi/XplQDqPQE89aJ7ytiUubreCQpjhPGV8CHiWOMC/1cp3SaXgkFNMgm24FvkUN5/CV4Vrs0aiBkKOS9t1fBF2rZB2By+W0Y6wPk9z2y+MJV5bKtNC790D7Objn1G3VfoWO07HYUguSrHnqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu3RhJDHK8NQ/BTc9RIVa9DVYAze0B7XiuFgHmNFtWg=;
 b=vdkNBUOKaN9542pAZ9FcgSh6drGF+QqPMpfJ4ZtTha3zuEhChaIwhKjiTaGsSE1UJcuetTFtQlZp6gMMAKSpQG44drQo9dgNscd+9ZwTfau8Jq7o00trfKy99arx51dLa4Pl/E7ImTZIw4JuCtD29oTrbYgmjlsjEf0ScMOKEYA=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB3809.namprd12.prod.outlook.com (2603:10b6:a03:1aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 21 Jul
 2020 09:04:09 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440%7]) with mapi id 15.20.3174.030; Tue, 21 Jul 2020
 09:04:09 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update driver if version for
 navy_flounder
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if version for
 navy_flounder
Thread-Index: AQHWXzIKmOmhGArCvkKnFpqgzD2qxakRvVWA
Date: Tue, 21 Jul 2020 09:04:09 +0000
Message-ID: <BYAPR12MB2888274C870F093FA9E2E7C9B0780@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200721073905.5041-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200721073905.5041-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5c1bc456-fba9-4359-a3fd-00009cceab9d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T09:03:56Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d09cc5fa-ea0c-4ac6-4c7e-08d82d550764
x-ms-traffictypediagnostic: BY5PR12MB3809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3809B5CB51AAEF826830F406B0780@BY5PR12MB3809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DOcHztIQ8Ev3iOQ4lU6kc0MXIM6MhH/eMvT3OWci3EZYem1OEAmT8pLjOzyiiVgrlLysr4/+flsxaol36i+oADNX7+xD4rtacVoks21qDcwe3WvEVgxcrzLHKXXfaH3gPQWLGGZqtnwHvRFH1DfTivkHVlhIIs9OIBoKpEF7SpdxAZI+oOxxCHQfdQ0hO9n80+/NkNxD2HJhNBMflg5S05tlqCRyRN/EggO5s21MvPaBeKpkejnSvCBhtPEH3NLXERnaw1/su2LpD2buuJ+wZfJXS8Yh/76GOLhHJb7JIgWEwlGKWd8RkSmM/Epof0lmmFj3a0CSXPfPIKdFqR3sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(86362001)(55016002)(7696005)(53546011)(9686003)(110136005)(71200400001)(8936002)(54906003)(6506007)(66556008)(66446008)(15650500001)(66476007)(64756008)(76116006)(316002)(8676002)(66946007)(4326008)(186003)(26005)(33656002)(2906002)(52536014)(5660300002)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ebLcDZyhW0s/TG02GP1qSGxfqRdw9pyIdGGTGjD2uA5MaW8Eu1LjQFvX65MR9O8ALRMxddnXflZ6MZbjW62wz4CoWpTsnFVt8u1amtlv6XlIOciEYq91liuk8VZlLGJ6jJghqnnhCjmFEJyU7otlldYsNxhiakqWqCQWm9aqRYICj6x1JqxZB8HIdVPMuOo+SZIFXPh2ig60HGtLGWLYEx5PxI+Px6xO7y23LJ5hVjWHyIFlsMvpI1mYFJQHJzar2u26yJnPR1+ACyu/5ezVpIjeOSJjLIp1qr5TpBRrq8ocozAt8MvRPWJbn+O6GYtvvHyY1j/GVC0XOKkQw6LKxDGs6StSQr1p2DvFeSUG9sH8NyOXG1ZvkwWbzE7UMD4Mh0kFX4D8kr0WJn6ti/3ZbtGxtk2gpAD3oGNhwSq/DjGsZSdMQmYa0XXWZUhfkuihgudij7H/MtCzh3tfDUGrRYGEkrgtdP0Ht5b5XNZvIgvWAOI6nEN+LCgd6hfTgBYY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09cc5fa-ea0c-4ac6-4c7e-08d82d550764
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 09:04:09.1329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLitgoAmLNT9JieUl1oTG2J2PwM5NMXHr4oJ+ujlVk5CCfwg8gzcGv0ll5vqBmqj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3809
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Tuesday, July 21, 2020 3:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/powerplay: update driver if version for navy_flounder

It's in accordance with pmfw 65.3.0 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I97b0a28e280c3ac5c63f9c17a47c08b2c9b7d65e
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index b18ee5837f50..429f5aa8924a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33  #define SMU11_DRIVER_IF_VERSION_NV14 0x36  #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x33 -#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2B
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2

 /* MP Apertures */
 #define MP0_Public0x03800000
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
