Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F77C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C255B20724
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JuiUcE3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C255B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780886E151;
	Mon, 13 Jul 2020 03:44:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 344F86E151
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 03:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmeYIKH8iLnZfSmNGHsiojJqV02QJyrDx0SbgTr5Y6Iy2xvm6PawwnAYGdPoUyA1moPIIdz3kzt2QNXMRY89NG9crC6sgI7ZLTtLhRtNy2wXZxrwxWVjrOnvUNd3Af9TO4Ek15G35oU88FVPzQVd27XN03RH0bmjJzzkOoaVEczjtrk63dyWfLpl1aSfI8K1CraRsEBMoWhHa/Y4muO1owbIE/zzAfaaA2C9HpFI5JqvVlfrZrDty5chTKI64TPXWcXx15Mtex6DZE472ElBeEYVz7L8G8n1uaH6STAFZwc8AJd1Hu7iW39KG1gsj6IIAEA2uwEn6DLOnMRL5fURrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yepnrc9LvqLPhGTEtnGWS6+oAbqk99+EvPyP9Ani4ac=;
 b=nM7c3d4F52iRMCnMuiQurecukEu4t9XkWRHM2DoyqL95ChhIfXHt0Q8JYJrOinF9wW+chjYQrX/vhmbFCUGndpUoawqBS+lpjhqCKJoWs8eUE9hCDHfoKa5csFYjSEgHqy32GH1TcwIFZk3nZrNUldQvbxZEyzLcIAwZ7oQDM6gpLcKTSMBMZEFKhHLwaRdG01IvHZ3EouB0qXbllSPECLji4RmJQrvxAmwfWg5HMxvjVj76012V39H2bSBUIceQsdGVnHytILD3Rz8hHVIHkFAHWzU4XJuM5L0eZa/KqTcEgpvHYpUuTjAwtAdSWTmoTgCaCLQnS+vRoeJnPyaHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yepnrc9LvqLPhGTEtnGWS6+oAbqk99+EvPyP9Ani4ac=;
 b=JuiUcE3n0HtUKr9SvkA98MQOBdSn1haDXZfgBq9LZjFpbhP5xHiGKN5xuJ0vfBRzjlcjsnLKieuGHgAIbikBppeo71Wyd5qrtdIK+rByrtrJJL/Yq03UncsFUfc9V8mgrjgnxlZ33uF94MMQF5WlZjTp471BYtJsmBN5L1w+E/c=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1772.namprd12.prod.outlook.com (2603:10b6:3:107::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Mon, 13 Jul 2020 03:44:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Mon, 13 Jul 2020
 03:44:31 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 13/16] drm/amd/powerplay: apply gfxoff
 disablement/enablement for all SMU11 ASICs
Thread-Topic: [PATCH 13/16] drm/amd/powerplay: apply gfxoff
 disablement/enablement for all SMU11 ASICs
Thread-Index: AQHWVnVcbomrprovwU+8M7QtboCN56kE4CZQ
Date: Mon, 13 Jul 2020 03:44:31 +0000
Message-ID: <DM6PR12MB2619A21F1F0177201E615D10E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
 <20200710044746.23538-13-evan.quan@amd.com>
In-Reply-To: <20200710044746.23538-13-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=670bf73c-cf4f-48a4-84ac-000074a23f62;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T03:34:37Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6ae400c-d9cd-4eb8-80fe-08d826df0d59
x-ms-traffictypediagnostic: DM5PR12MB1772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1772D7BA324B76ACA8460447E4600@DM5PR12MB1772.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E90B/lqZqy7Tu+biCyf3OWV8oU0x4epDVz3Bu6zpSbwKWo+fPRvRTVnktlr7OUoeztm/FBkN9L7T4orh9I+PMDAtVt088/QOya2m8GV9X1aJjIiARF/MOGVkEenp+e5zpDmPIyJ2AUywyZeKLGYcD/051M3MZJph3XVjJftB4ijdrxGnWkvoWkYW8g9gt9538LCSU87Yq1rcUH6ojEuYs+Bk7p7fmHfBD8H1ihOmV9Bn2qKSLL+WCgyNpk2LaVRNhO3dvlxrDZWVsUTBmrekp5gHP03JhmTrjrmRjMYfo7I7Vc0txX7lsb5jeJ4WWaFu7UqbY9tcpA4sDiiL5j3ERA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(71200400001)(52536014)(478600001)(33656002)(8676002)(66946007)(26005)(76116006)(5660300002)(86362001)(55016002)(9686003)(8936002)(4326008)(6916009)(186003)(316002)(66446008)(7696005)(83380400001)(64756008)(66556008)(66476007)(53546011)(6506007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kN7qZqIqoqdZHBu5qmznMvA7MUkIICIzv81YFPNOxizKV01zkPqZh6jcctllCLyQfIZC5gJXRgmuLXXAg5iHLn/PjOw/todh04MKiBuBCae24R5iKBF9uNeV4C7Y28UaA8wo1OVroXQ1qp98ot0iNKP6D+WiyWgchNR8etbTTFxrzxsaH0s4LSlq8Ym3d0arRiQe/7yl2aiyMGShbAPWF4bkr9FWvDbMgCq+WA2irCzPHpzJOGk17vH1hkbJWLA2ftFVZM2Qp3TjAH68REsSaAcee8I0gl5a5xfASSDEMrkesQS6yMG5HVznwOo6bYeAJMuwvvcSgvWVtTBY4jxvih2Cae7MHd2snBz54agsl1Z9wi3LaCEI8lnkMG280ilDSMkH1wQVfScmJlU8dztOxcNj+rweUOm73W2EYqM7+m/aXG5kHHKxI+NWrl9IZ0cEabpLw/mv916af+uwTppiPQ6hgp8H4guLJxW6qeHdN4LUUQCee36xGkMJODpw5K+L
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ae400c-d9cd-4eb8-80fe-08d826df0d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 03:44:31.5667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJtDsCmc3FRvg5x05PhKrplTYmtKUDjQAAGQ8lvb58IO8RCDxpCrIuX8mLzXtoYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1772
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

[AMD Official Use Only - Internal Distribution Only]

Ping for this one and patch12, patch2 and patch3

BR
Evan
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, July 10, 2020 12:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enablement for all SMU11 ASICs

Before and after setting gfx clock soft max/min frequency.

Change-Id: I6f828da8de096ebc0ae27eaa89f988def2d547ec
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c2779d0b51f6..33e0718f2635 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1758,8 +1758,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 if (clk_id < 0)
 return clk_id;

-if (clk_type == SMU_GFXCLK &&
-    adev->asic_type == CHIP_SIENNA_CICHLID)
+if (clk_type == SMU_GFXCLK)
 amdgpu_gfx_off_ctrl(adev, false);

 if (max > 0) {
@@ -1779,8 +1778,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 }

 out:
-if (clk_type == SMU_GFXCLK &&
-    adev->asic_type == CHIP_SIENNA_CICHLID)
+if (clk_type == SMU_GFXCLK)
 amdgpu_gfx_off_ctrl(adev, true);

 return ret;
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
