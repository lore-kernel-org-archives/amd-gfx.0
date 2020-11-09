Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D36BC388F9
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 01:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393C320678
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 01:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="faTGxp5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393C320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B901389483;
	Mon,  9 Nov 2020 01:23:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D14689483
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 01:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxvZA77oc0qy+RgKfFnFoAcboSUEVtI7pBcgjEEGCOxYVHAz9Qx65fx5rILxSIxnltN81sTCP9sCY1J1QTo8NxX9JPjViAFxDnW7P4hk16VWdQ4Fb8SjPjH6+XS/GPkwqYxaKEGVz1HdCs1H2IWmeDrkKpG69VeydVdM2ezhQHXzMyRg9bYTlW3XQAi12vt8DYi3u33Rq+7uE6AyumNSjS6poBw2cV+MeENbleQMSxxmEh6p2BLB4gyGZBZFcsGvEagDypZCvNbgAFDtnezFMhhvWJEWeQnOuXcJxMBpXY0rIOqPEgcTwgWIAhsksuAoGiXkWHV1QOqkPY7sz7/T0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqNHPWP8UjbdIQ9JSO36Phi0YkTsraMkHBykIk+ockU=;
 b=IJ4Gs7o0KxIHaY4ZdW/YzsEtWDx4WbRm+pZAwwcCIWqTGVraVucPbD+TazLRySi19btH57BP2exaP/3Vg+FBZv+uUsd6QJTgtbqTcxFss1qZndoF49jhAHbsAU4YbOP8PDvitjzXXjHiVEfN5jYU5zJllGRyVTwy5imnPqHChwSugga99010GQiNxklADm+8n4y7lIGc48BjS25OHhLyycmW1Ixpoa4W19TMUlx3R0CG+1YvcopygMGCpgSghlvwn91Y69lR7TJynB5H9vI9zqCHotP2tPRRGBiJUJvOsjfZjpbTAtX1k1YbZVpBNoqkEhqd3tGe0rCokC85RqciZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqNHPWP8UjbdIQ9JSO36Phi0YkTsraMkHBykIk+ockU=;
 b=faTGxp5QBwUcMlFHcrVGXrcJhhPoUBvUJpfEyQuU9WUMz97TNhRd0r2x88SrDG0IbKAXNYQNowvsgyh0jRlx5hPUR/5daHZHxd3mWi9k9S9iXfPfzlqJ56xgReIbAx3zVOS8/TWQiA3txQshcEArhhr1MhhLjx1KU7NErqI4mjc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Mon, 9 Nov 2020 01:23:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3541.022; Mon, 9 Nov 2020
 01:23:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm/smu11: cache smu firmware version
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm/smu11: cache smu firmware version
Thread-Index: AQHWtEyqs19WCk8Jjk2Ijl0ydmDEIam/BS+g
Date: Mon, 9 Nov 2020 01:23:30 +0000
Message-ID: <DM6PR12MB26197A44CD6C353BB5F7FEE1E4EA0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201106145347.421966-1-alexander.deucher@amd.com>
 <20201106145347.421966-2-alexander.deucher@amd.com>
In-Reply-To: <20201106145347.421966-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4bc00ab2-3a6b-4497-b570-ec33470befe1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-09T01:23:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c350e289-9a13-4949-20ea-08d8844e1147
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41243D844607F4CDE73A0634E4EA0@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDrcfY46PiZKcYlw2r8O5SA+dK8MOyxJ6wRghhPcC+GMUsrlQkoS1g8n2AuuwQTzE6eF0Zu7948854I3sLvu/kpTliXNpGQRBwjM8cxtnlNBCrIVlIZNyNQaoba0aDIQKxfOZ5ZwfTww6iFHf3pWB0NPjwzBJy/JCaowBZo3jpNoUAKCQjCyyoVm6yShVHWITm8G9ppNaAB2eSb7YiQ304q0K0qQQKNwzCAZEzbiCVOiXc2adLX8Z5cIJ5S2fwT4kBq3892mdqOzO1AKB7XaSOnOudRpypRp9W4KoDqnOZOtYRiivA3jKvsh7NTNUpO/aJYIDCAjNec3ZUFL5342K9hn0GL8TqAqhvcJ2UMunoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(2906002)(6506007)(53546011)(8676002)(110136005)(7696005)(8936002)(33656002)(186003)(26005)(83380400001)(316002)(9686003)(45080400002)(478600001)(76116006)(71200400001)(86362001)(66946007)(66446008)(52536014)(5660300002)(64756008)(66476007)(66556008)(55016002)(966005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XUcEwFq6pfDMyOrjVdVDWEDlsm3JRR43MAq8YRjFYhZFyYDBzgS3AwGjV3ohjvDlrhMjA48znKMOAmX+bPqeRqpPSH3kXN6wQRIUV+jaV8e1NhyXLUc4Gf0jQVCSc9bNScevYEg3tFFG6apFNpqSpwCZE8wWb4x+hrJfsX9EXXOvd/R0SVPXsgc4ldqm8KtYFvevJyj8mGPvuiAJ6BuGqz9NliTAn0KPA0isRR2dcCKjZQGwil6irm9uJdYrOA5n8YWsL1PnT34RbNqJHksecYC1rWXIvFThV+H+GbbhHEu2hz1ik9mOanJh236O9bNYdgjowqkU7C8sYfrniTxZ35hrTtjx9gHigaEO1ynFtLlThjee7wE/Ud4S6sxVPSVToE7cWsSJ18C6FJCqbr2y+zX0RiSwuNrylehNRPntR0gtEU+KzFQ8Bn9aJn64zkfN/Kb+IIiYjVW8658nMgO4Dulky+7GgIzUcOE71bgto9n5gnVEz2G+tvfb7XqgScTuIOmLQrWNv/TZ6f6WdzdQt5fIibi9SXmsTkR/APRIbodjDFghlPRW8EBcrlUqty8FS4IVHEuFXVKMPUdwRiuozwmXbZKXr28kzasYo8V3ftCTejBVBfbs0b1qupCnImhAhOeK/hYK/lSH4kddq/AMzw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c350e289-9a13-4949-20ea-08d8844e1147
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 01:23:30.4085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbmmN47Mi0iKJxNkZNgmo2khnOFo+gckpGe6/OjyEiL1389Kq5EMxbq6rnfuT8Gs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, November 6, 2020 10:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm/smu11: cache smu firmware version

So we print the proper SMU firmware version in debugfs, ioctls, etc.
for vangogh.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b6453ee6f8e6..6b7d1335b46d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -216,6 +216,7 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)

 int smu_v11_0_check_fw_version(struct smu_context *smu)  {
+struct amdgpu_device *adev = smu->adev;
 uint32_t if_version = 0xff, smu_version = 0xff;
 uint16_t smu_major;
 uint8_t smu_minor, smu_debug;
@@ -228,6 +229,8 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 smu_major = (smu_version >> 16) & 0xffff;
 smu_minor = (smu_version >> 8) & 0xff;
 smu_debug = (smu_version >> 0) & 0xff;
+if (smu->is_apu)
+adev->pm.fw_version = smu_version;

 switch (smu->adev->asic_type) {
 case CHIP_ARCTURUS:
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C696892183cf94398b1f808d88263cbf8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637402712429771842%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gNh2xA3ve9EXcKtTLIN4mBt8zgARin3zj0jNVqPIk%2Bw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
