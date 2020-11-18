Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9969C2D0E4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 02:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3462465E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 02:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EvcA8IdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3462465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF8C6E22C;
	Wed, 18 Nov 2020 02:28:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E6D6E22C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 02:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah7X5IRZ7QEtABLePo2YdLNjDXDtWPRS+prkU8pRPlCRF9uywF0WiUBebvBNPEnrxskJbn5Q1aAozS3heh5qlKIozy6prnFQkw81+qOR62pfcsDQH+d6hsM9ARTn/47Gpw0EmlJ44hoLhVXW3M8oW0XpQ5jEQClPhH5KK+2uY4HN8jKq1ZljUiWzNHHVZOTUE1QmaecjBmcUEKeorF0A4W1enGbc3wg0f4//zq1Jg352orwmj6rlTGNyxW36mOrLJ/D5rmTE63ZPbm4/4ydtRm//FqnoLU9GohiXcq7wwTb8k1tWvgVhw/BvbAdEhDRDKmblr8gW8y5JZNliUkoc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RRcI0+G+El8t+3wxHYDREThx8z0yYE5/3UiDnBxMZs=;
 b=MoozH6dMHtewR7IoZ2sJNf/7lsbwTPTNUHK0r88aYTvFyM7HlSraOfnLMeD0YWNjf2KKLPCnCSvrIq5TekZC6NpD9nfVubfZ7VFtqz45smooDc8nwDnpBmOMUmvXDM0bpV2Nlw/B6SnfzqJQXloTI8l2EvLtIMqn7btZpebWeMOZFpJ9x6oSj0x429S9EVkZSWUdwpAg94sXH1it7reuNMVwG+tMcWnN1pfwvoT9X/UuR7yiXGEG8/ahd3qlf+rrpAImTgP1EeSBgUoOFVYOINRf05u1eOhrjBPDwvt9xSAJONYPZYPbnkzu8XvEiaN59uUxmevKRl1oL1QQFX+8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RRcI0+G+El8t+3wxHYDREThx8z0yYE5/3UiDnBxMZs=;
 b=EvcA8IdGcN/WwNBjy0zXTWrISrvX74m72yB4o9k6SayqltzoV2EMVv7N7HRoqUMLN77vg5uFtXzE6X4Dr5WmWfbuYXtMMD9EFHsGB22MqG+UHJFiKTjPc43mpBZwJUYHElC6W8YKGSatbNPPlMqfi1gAZ7wayb6OWHxKm1suA6Q=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 18 Nov
 2020 02:28:20 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%8]) with mapi id 15.20.3589.021; Wed, 18 Nov 2020
 02:28:20 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: support runtime PPTable update for
 dimgrey_cavefish
Thread-Topic: [PATCH] drm/amd/pm: support runtime PPTable update for
 dimgrey_cavefish
Thread-Index: AQHWvLPk7gW7CqT2LkyhM7q1eM0BaqnNK4QA
Date: Wed, 18 Nov 2020 02:28:19 +0000
Message-ID: <BY5PR12MB488538F05667A1B126D3706AEAE10@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201117073240.10777-1-tao.zhou1@amd.com>
In-Reply-To: <20201117073240.10777-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=639a8ef0-7568-4c46-8d65-57353edefbde;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-18T02:28:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4736102-9dc9-4427-5ae3-08d88b699d6d
x-ms-traffictypediagnostic: BYAPR12MB3560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB356019D53AF7EE177ED02DB0EAE10@BYAPR12MB3560.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 36CjfsDHOcqJIsdeKolTDP5wmQ8SflEpx7RtzjTKUaJ4JPUAjHn3Zu7bZf9KpJnXksjX97O4hfBMgTQV+tDj8XaVnHIaxebtR45gL6VZHH/vkjCyea1X7hxsKNzdW3kbtEa0o7m5GVFQbzWZCtv4zgKEM10frDTzL6NZXAR5c6hTU6GVIxQQnhLb3s0E6rHaCe3wV+RIqmbXfGReIgQN2BNp+IfwDVvOGBF8GnFk/1zG/ymr75PBkbGEcRAIkj2lY1caqo+pV8HhDy4ift0y8aMvE9JAyJOXX6fcgnl7KTyiA/IKukY3e14zFam9Do0SbgtJzKdpcf29RDIDtC6hGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(110136005)(5660300002)(478600001)(66946007)(15650500001)(7696005)(316002)(76116006)(8936002)(52536014)(66476007)(8676002)(2906002)(64756008)(6506007)(83380400001)(53546011)(186003)(66446008)(33656002)(26005)(66556008)(86362001)(9686003)(71200400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0Za0QDDcQRvngTjYI5oPwAHiAFz/3Eh+ckWVmj495l6IMa5xt8WNVVjM1qYw7wTlffP4vvsXa0VZCq9VX3k0MVDA1La2bXqPDQXaRbiZScb+Sv8ZimiqdDqogoTBYHsXVKNj8YjbZpIfzyAjlmV0+j2w2sXccZabdfSL87wJET7WwEeIr0tAIAYbtaBOiTFBya9CxhIlG3HYvgVw8yHVt8G5lBPSCf8Tm3SCftkvwFJw99N4xVjVXNSEda7TqdfX4Qa79hdYqEo4RJ12LqLghCfAA7Ejl8YwzYN0qbrZNvjAhMRzxJ3r65yh1wGDNhd33PE3ixMYSDGZnmjVKoLg1JW1FWEnTT2M8muaMuMsbLXhq4MdhqKw/BcWezFovL8OQ/AdpW/g3W8ENZorNuE1BL3Z/lpfwGMQekFOZxFbt1+Y0Xe9vD9Siz1C/O23U72aR27kdIvmjz90AAnF6Ks+iuS2uY91A9mdDn7o8kTS2GXyOEirwA2HjDBnvlrXKg9W4blJZYbIf1Di9D6HReG30i9DVC6n3Yv8o2xwLnX71mi2lSLw20O67LhB7UQFJlXpQ4b2DBQeM5IQUmRhDZbWkwBeDi9Rw9iVPYcHRkKL6sYRgZhGFO7r21+DohPiCA5HPV9ticDqoxjHOxO/jmp38Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4736102-9dc9-4427-5ae3-08d88b699d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 02:28:20.0308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LENK+YNjgDqAF0NjUJnIGpPtyUSFniunerMFWimrxOEWtkVk45YTHdHGQk3CiOs8lRhJBRU6gMUvZtfQiM7/Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3560
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

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, November 17, 2020 3:33 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: support runtime PPTable update for dimgrey_cavefish

There is no need to reset DPM for PPTable uploading on dimgrey_cavefish and PMFW can handle it, same as navy_flounder.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1904df5a3e20..8e3e7a5bbffe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1183,7 +1183,7 @@ static int smu_disable_dpms(struct smu_context *smu)
  */
 if (smu->uploading_custom_pp_table &&
     (adev->asic_type >= CHIP_NAVI10) &&
-    (adev->asic_type <= CHIP_NAVY_FLOUNDER))
+    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
 return 0;

 /*
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
