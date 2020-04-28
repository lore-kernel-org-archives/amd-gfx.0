Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B5C83002
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 01:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F35C20661
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 01:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wdGdo7ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F35C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B286E12C;
	Tue, 28 Apr 2020 01:18:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0435F6E12C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 01:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR6uPlu84es063aKlrWBdozljE/bM/DusGx/FhkU4W6TLDyxK6N4trFCmqRK0SBPpHp41iUX/dCGnm1glImBqjZd602L66kslyqINBtp9T2QSUQn6lc/8ed1iXDx1FXkm3TtWQAA6riJa4+AC5VuH4eWKYfchS2/MUCMpytqgLr6UoPnoI0dastbBKPdIM7fYo0MlBeyX6KXSOUTjBGWua4sY6hyEdHKIR6WT38pZRc1xdtEwIGuazvrr6Puu+BwkSsx45PSsM0zX/7bVO6zEaLhEf2AIkRVyE/JvgNQSR5LU30t60swX4n7sDw0pI/sGoESSapcDnPACAfj2R4X7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0v1tRLQBVJD1awnXW2gFn/lqEMF5nyWFYHB+KmOvyE=;
 b=gaXz88w88pTgvpGk75ugcLtmPxbVCmmNoS60JaMC0HfblsOXLdDbhX8YiMpBEV6sRBvym3PtLEcQmx0P5K47xmzSFjqqVFG2VKlWdIeQtB3VEwPH1DlYy8PebVEmB78nAg4rqIylfO2ysRBETOryrOiYwYYAxexQfGHN5TdDQK9onC9PRqgWQtu+4uU7jzWQ2eNPv6iTtnnZvGFW/HdpANWDpnBhz7MQNJAY2MU9rZe3VFqZz7JUQsknhoSY1MbVB6VKKUWQXcCo2ljaZkWqpAfulcIp6P+liEnTEjZsl5b8rdZ9M6dWsJ50d0qEZ+J1brShmNRVboyxhaS5GRVhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0v1tRLQBVJD1awnXW2gFn/lqEMF5nyWFYHB+KmOvyE=;
 b=wdGdo7ZL4Ag/xnwi0o40S173/1iVle73W9PBdXmeGtaDLcelyJR/xf1PpJs+sEME7GNHoRjvEgnupG1HKmgHTgFCIYleH7JEXmZTJER0ORI1GTPV38JrYdkXEK63wkjOgrfwuz4cc0pZeqxJEg/bG49IeJVrTObc8m2ztKNlks4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2922.namprd12.prod.outlook.com (2603:10b6:5:18d::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 01:18:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 01:18:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: avoid using pm_en before it is
 initialized revised
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: avoid using pm_en before it is
 initialized revised
Thread-Index: AQHWHEQ8qyqc36KTVUCAHmun2CX3X6iNvQrw
Date: Tue, 28 Apr 2020 01:18:29 +0000
Message-ID: <DM6PR12MB2619F59B6703E9EABFADA03FE4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200427032932.13333-1-Tiecheng.Zhou@amd.com>
In-Reply-To: <20200427032932.13333-1-Tiecheng.Zhou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=68be456f-7ca3-4daf-95e2-00000283eb90;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-28T01:17:31Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 144f9c99-ddc9-4050-ef08-08d7eb120f56
x-ms-traffictypediagnostic: DM6PR12MB2922:|DM6PR12MB2922:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29226D1ED5225E1AEA02AE77E4AC0@DM6PR12MB2922.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(478600001)(64756008)(66476007)(66946007)(316002)(966005)(45080400002)(66446008)(66556008)(26005)(6506007)(7696005)(5660300002)(71200400001)(52536014)(76116006)(53546011)(8676002)(81156014)(33656002)(2906002)(110136005)(4326008)(86362001)(55016002)(9686003)(8936002)(186003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkDHxIsN5FSR+SiWBTc/UvU9yThPHJjZKA0goiXwqmvNvlosLl/ulzzGA3iIAozea2CBF0LJzLraAPysp6xvEsLNncQOBJReNqKY6sD5yl7GdQ0vQICB8Fy3Omya+8C+ISsG9Oelu3DjCgzwRCjYB6xjTX2gZlmbAiB6emvhZYwUfZJpsjMfG4+emAt/BgLTyZo+zmGc8zcNtrfsHA83BV9247vAFRy44lYYv5GROjf6tZtax6ZFph7dI94I8ZPVqksFGfSax7fNeYx0zs0aDKAy1zVyhB5B4Csy5s0O7MD9EZcJ6iYD2Ta1s85xJ9j9xnXJrhj7D8+0fThadU5oleGSzfpz9sm+uUy+fFr8EX3rVmQVLcVoI9qsgwZvCB9abhV+Hf7h+g13/86CnBmavBA9Bt8XWIFLpmHVw7IlF6EyXfWv8vCHe+bxsXvkslo/oF7E0PGexfVX/v/7ZzPHeWFXVbFs8yL64Ipj0uTi0JE=
x-ms-exchange-antispam-messagedata: AMjgZItkumD0BYSGch1HsajCQpIzMwxDJV3SYUzjSqHAN9sA87sc0Bj+n+gOJvoW2O6UwhJuvvN9EK0At2uFk6F3hhmx/Y0IVl58ruhxCZxxxWXht6IAXaNEmIzWsNt+Up8Tv4v7PykAQWYAXiapEUzLmmiBJy4FHgONZhm/hFQtTn+VvpbLBuN1r9P8FY7EYQsZTq9p99rPnNw5jg8JqX+eUc4E/S9FRYB8Q6Jp1lmUFliu1z59l8oGbhLb4u1oEX+J1LmaiHKpi3eyylig7QoHTOTeKzK2upCnYcuRdAr8TVHUyRteWG4M6TvRt/J1Hj0d6IDdAoplZbHXiOE3PzmVGXZkHLIhBSleL4Nz20clY89ZYsg6DjDKhNtGx67VHvwfJW0PIHscx++YwWygDGvy3t6sCt6OQNTEK50aKiLxCNba/rMoh7wE09x3/qtXo3apsNcf0BP+RDGsYxN9sJAUsp+6TdW7kRg5ji2VBmqrRWsDA/++re/xUAZmvUZcdlBCn4Bq01XoogPD7OkCAamh8Txo8LfKVRZlDCNCW9JH4oalxFPZwWOK99LqmtLRvgljYg+EzMDWpIuiJ88yJXW5srUO/FUdXTqmOFEykTM5qf/jlTbBobY49Pjz9oZHW+BHwLAh94ACrWJSVQ3ZSKFVHQU2kLmVBOjVm4USs5JZIl7UyoeQCFyRdog1MYhHaUK1wRoQBMdNAX/X0rHI5INZQiyM32vHciHcBUW/Q3OpltOYq/2Nwj20ckKuNtxZnPfstAkvqDzHbnVIcE3KjTPQ+lyp4sRMT/UV2l2eJ74=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144f9c99-ddc9-4050-ef08-08d7eb120f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 01:18:29.4126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jL7jV+stxUJsedp3c63ATQyOqd7cNr4jk+/t31WIKuuBH/tTXF+q/v6CPZeGdcey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2922
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
Cc: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series s reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tiecheng Zhou
Sent: Monday, April 27, 2020 11:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>
Subject: [PATCH 2/2] drm/amd/powerplay: avoid using pm_en before it is initialized revised

hwmgr->pm_en is initialized at hwmgr_hw_init.

during amdgpu_device_init, there is amdgpu_asic_reset that calls to soc15_asic_reset (for V320 usecase, Vega10 asic), in which:
1) soc15_asic_reset_method calls to pp_get_asic_baco_capability (pm_en)
2) soc15_asic_baco_reset calls to pp_set_asic_baco_state (pm_en)

pm_en is used in the above two cases while it has not yet been initialized

So avoid using pm_en in the above two functions for V320 passthrough.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 71b843f542d8..fc31499c2e5c 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1438,7 +1438,8 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -1472,7 +1473,8 @@ static int pp_set_asic_baco_state(void *handle, int state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_asic_baco_state)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->set_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C083ee458638840b718b708d7ea5b3934%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235550456598209&amp;sdata=hn2iTGG4U5RgB9QEwYbjZkSwbcpo3wjMsiMu%2BJc%2BbuA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
