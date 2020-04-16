Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F57C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 01:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6E020656
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 01:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wdwKgAwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6E020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE2A6E216;
	Thu, 16 Apr 2020 01:40:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFE06E216
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 01:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGlxzqKjk1LQ415QPAYMcjuR+DxQdWYqHM4HWIz1900s0bcoiqsNJwaXWjerplawhdjnodaadmRjZpclRyLOmCC4PAkUxLklEn+WSWup19wawVd+BD19hsRCJKccZiDIwkUVME40M0Yfxt2GW1ExNUkxxKy2TgOMFRKXAb36gwEqMGcvnYjBBtkr+UfCUlBvaJBnY3q2bcB83Pdht26dbEzkvFrhbJsKw8zkyvdP+7EiPKweJrgXWxyM4fOtY1GNc5UmROqzHXiar0Ru7YC9dXrO6kWe9m+Efqy2J9osWtImV/qu7DnXCqRtubp39TI+SmkOMRRCr4pWmXoqzNxRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFEgrhHb26XbM10KY2tu90CDpjMq0ECkZdzADqJTjgs=;
 b=ah+alYfeM2gYSyQubP2CslMoDn2vsD9m0lTlX8gzfJmkMs+6F0nJLyYhQUiv5UW9gLP/r6P71fK6Sg908aC9PVlfJJ5/Hiiw+peyFAxBeWGjMKLr7t4XINoekjr/HDxoKT1xC02PMtp2th5zGPgQMKLMc9zJXI4OKw88RNy3XPJIfDyj5MlfCCjtWfb7j7XGdLGiR9GTGZiGq+O88+UcfvjTsUeplQoO2cjcq8dAME0rR1xHTa99Uq8xoCcUbDQIX6yyiiUxMV+FtXVd4Z8e3sZsuS45EnqcgJfD882fRusMs9nJkrFLXo0/68kdkna5Zttt4E3bOiUJ6I8YEAH9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFEgrhHb26XbM10KY2tu90CDpjMq0ECkZdzADqJTjgs=;
 b=wdwKgAwWxDYOoPhTo1+meABgxG2iGDpVEOEqpTXQQqq8EpR2nX7kNLaE91Bs7KDW1GLClHUAlzflY/QGQIT0FRBwBlG1WgJFIhToJjLiFDfUyY1U8TXcQxJUb/9BFP8Xt/ack5aRBsdaDj12iJxnV7KnGW+0MvAvT1erFrTUifs=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3629.namprd12.prod.outlook.com (2603:10b6:208:cb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 01:40:18 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8%3]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 01:40:17 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix resume failed as smu table
 initialize early exit
Thread-Topic: [PATCH] drm/amd/powerplay: fix resume failed as smu table
 initialize early exit
Thread-Index: AQHWEzyh5UHYRqatxUCjVuKkzELZXKh6+WMw
Date: Thu, 16 Apr 2020 01:40:17 +0000
Message-ID: <MN2PR12MB33099B31C31AD31E8DC14E47ECD80@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1586965404-31922-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1586965404-31922-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-16T01:40:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2cab2419-7027-42e7-89c1-00007facbd9e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-16T01:40:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 20273f82-5903-49eb-83fc-000052e47a37
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f873509f-7cec-43ac-ef65-08d7e1a71e3e
x-ms-traffictypediagnostic: MN2PR12MB3629:|MN2PR12MB3629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3629D41944F673B8F0257C77ECD80@MN2PR12MB3629.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(26005)(316002)(186003)(55016002)(53546011)(66556008)(4326008)(110136005)(66446008)(9686003)(64756008)(66476007)(66946007)(52536014)(7696005)(76116006)(6506007)(81156014)(5660300002)(8936002)(71200400001)(478600001)(8676002)(33656002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmz66Kwno+AdKne6bjKABfZ6pEkMk+XYmNidAMb+OYsGlYZCOoA09FRuHvbumyycio8HwDDBdPNy1qOfLDVzT2c2i9Iv4JNEN3EOs+4KGYaC2v4EOa2otssp0Sr4R2u87le9RtqsOIkKF1QHyuUItpxFxtNOsbK/IfV4kyuSiB2VHvgPVB6A27a7+Ke2q36zXBW3nQi+mccJuHirBdayHz7zHmHcmTTh/MdFLPSgecyc6Iw1idGp1b1AhjLqBSI0NGDnTRclVNMp5wa/136HTPQbeJOXHaTtIx7f2J2VtALAxZns4JbultX4QwmLl0xTmMUf87QEpayNG4CyHgmXKXp3UiLRfG/Qjt8NppeXk8G8KjgRsmpGgQgXhawHv2jTTCbdfO8B8FTy8XY7DfroZl7vCTMJ9CUYH34pgk/oVyDjKv89oVhR8mqRzV7fitmG
x-ms-exchange-antispam-messagedata: OXCI6W3kD4Ya1yw0ZXTPvd/rpLfVJSQDcVxA93roGop0rKhCug2TkIvyCPkEp6OGhVR6eM3R5a6MB7MPMjefW9F+VXac6SuWW63Mpn2m/wSMp/xwiuP8LAxgyObvTVU/09lD4/5I4+R0JJ6yWgD/Sg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f873509f-7cec-43ac-ef65-08d7e1a71e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 01:40:17.8504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+PhoEB0RttIurHHfP2oOV2Q444ilBl8xih+/AwC2g7nkRo+eSo1HPvSSkqqq14o3SWAQFytrURYOaGVieJAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3629
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

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com> 
Sent: Wednesday, April 15, 2020 11:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/powerplay: fix resume failed as smu table initialize early exit

When the amdgpu in the suspend/resume loop need notify the dpm disabled, otherwise the smu table will be uninitialize and result in resume failed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 95eb445..7ddaea8 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -895,12 +895,17 @@ static int renoir_read_sensor(struct smu_context *smu,
 
 static bool renoir_is_dpm_running(struct smu_context *smu)  {
+	struct amdgpu_device *adev = smu->adev;
+
 	/*
 	 * Until now, the pmfw hasn't exported the interface of SMU
 	 * feature mask to APU SKU so just force on all the feature
 	 * at early initial stage.
 	 */
-	return true;
+	if (adev->in_suspend)
+		return false;
+	else
+		return true;
 
 }
 
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
